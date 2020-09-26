//
//  Media.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/10/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(iOS)

import UIKit
import Photos
import CoreGraphics
import CoreImage
import MobileCoreServices

public typealias ImageCompletion = (UIImage) -> ()
public typealias GifCompletion = (Data?, UIImage?) -> ()

public class Media : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: - Strings
    
    public static var imagePickTitle:String = "Add photo"
    public static var videoPickTitle:String = "Add video"
    public static var mediaPickTitle:String = "Add photo or video"
    public static var pickImageFromGalleryCaption:String = "Pick image from gallery"
    public static var takePhotoCaption:String = "Take a photo"
    public static var pickVideoFromGalleryCaption:String = "Pick video from gallery"
    public static var recordVideoCaption:String = "Record a video"
    public static var cancelCaption:String = "Cancel"
    
    public static var askForLibraryPermissionMessage:String = "Application needs access to your photo library."
    public static var askForCameraPermissionMessage:String = "Application needs access to your camera."
    public static var openSettingsTitle:String = "Settings"
    
    private static var photoCompletion: ImageCompletion?
    private static var gifCompletion: GifCompletion?
    private static var videoCompletion: ((URL) -> ())?
    private static var universalCompletion: ((UIImage?, URL?) -> ())?
    
    private static var allowsEditing: Bool = true
    
    public static var customizePicker: ((UIImagePickerController) -> ())?
    public static var onFinish: (() -> ())?
    
    public static var controller: UIViewController?
    
    private static var _lastImageName: String?
    public static var lastImageName: String? {
        set { _lastImageName = newValue }
        get {
            
            let name = _lastImageName
            _lastImageName = nil
            return name
        }
    }
    
    private static var pickTitle: String {
        if universalCompletion != nil { return mediaPickTitle }
        if videoCompletion != nil { return videoPickTitle }
        if photoCompletion != nil { return imagePickTitle }
        LogError()
        return mediaPickTitle
    }
    
    private static var hasVideo: Bool {
        return videoCompletion != nil || universalCompletion != nil
    }
    
    private static var hasPhoto: Bool {
        return photoCompletion != nil || universalCompletion != nil
    }
    
    private static var hasGif: Bool {
        return gifCompletion != nil
    }
    
    private static func clearCompletions() {
        photoCompletion = nil
        videoCompletion = nil
        universalCompletion = nil
        gifCompletion = nil
        photoDialog = nil
        onFinish?()
    }
    
    //MARK: - Properties
    
    var isVideo: Bool = false
    
    //MARK: - Static elements
    
    public static func getVideo(_ completion: @escaping (URL) -> ()) {
        videoCompletion = completion
        if photoDialog == nil { setDialog() }
        topmostController.present(photoDialog!, animated: true, completion: nil)
    }
    
    public static func getImage(_ completion: @escaping ImageCompletion) {
        photoCompletion = completion
        if photoDialog == nil { setDialog() }
        topmostController.present(photoDialog!, animated: true, completion: nil)
    }
    
    public static func get(_ completion: @escaping (UIImage?, URL?) -> ()) {
        universalCompletion = completion
        if photoDialog == nil { setDialog() }
        topmostController.present(photoDialog!, animated: true, completion: nil)
    }
    
    private static func pickVideo() {
        checkLibraryPermission {
            let controller = Media()
            controller.isVideo = true
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func recordVideo() {
        checkLibraryPermission {
            let controller = Media()
            controller.isVideo = true
            controller.sourceType = .camera
            topmostController.present(controller, animated: true)
        }
    }
    
    public static func pickPhoto(allowsEditing: Bool = true, _ completion: ImageCompletion? = nil) {
        photoCompletion = completion
        Media.allowsEditing = allowsEditing
        checkLibraryPermission {
            presentPicker(Media())
        }
    }
    
    public static func takePhoto(allowsEditing: Bool = true, _ completion: ImageCompletion? = nil) {
        photoCompletion = completion
        Media.allowsEditing = allowsEditing
        checkCameraPermission {
            let media = Media()
            media.sourceType = .camera
            presentPicker(media)
        }
    }
    
    public static func pickGif(allowsEditing: Bool = true, _ completion: GifCompletion? = nil) {
        gifCompletion = completion
        Media.allowsEditing = allowsEditing
        checkLibraryPermission {
            presentPicker(Media())
        }
    }
    
    private static func checkLibraryPermission(_ success: @escaping () -> ()) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:          success()
        case .denied, .restricted, .limited: self.requestLibraryAccess()
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization() { status in
                sync {
                    switch status {
                    case .authorized:          success()
                    case .denied, .restricted, .limited: self.requestLibraryAccess()
                    case .notDetermined:       LogWarning("notDetermined")
                    @unknown default:
                        fatalError()
                    }
                }
            }
        @unknown default:
            fatalError()
        }
    }
    
    private static func checkCameraPermission(_ success: @escaping () -> ()) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            success()
            return
        }
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            sync {
                if granted == true { success() }
                else   { requestCameraAccess() }
            }
        });
    }
    
    private static func requestLibraryAccess() {
        Alert.question(askForLibraryPermissionMessage, agreeTitle: openSettingsTitle) { openSettings() }
    }
    
    private static func requestCameraAccess() {
        Alert.question(askForCameraPermissionMessage, agreeTitle: openSettingsTitle) { openSettings() }
    }
    
    //MARK: - Variables
    
    private static var photoDialog: UIAlertController!
    
    //MARK: - Controller
    
    private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    private static var currentMedia: Media?
    
    private static func presentPicker(_ media: Media) {
        
        currentMedia = media
        
        let picker = UIImagePickerController()
        
        picker.sourceType = media.sourceType
        picker.delegate = media
        picker.allowsEditing = allowsEditing
        
        if media.isVideo {
            picker.mediaTypes = [kUTTypeMovie as String]
        }
        
        customizePicker?(picker)
        
        topmostController.present(picker)
    }
    
    private func extractGif(_ picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]) -> Bool {
        
        if #available(iOS 11.0, *) {
            
            if !Media.hasGif {
                return false
            }
            
            guard let imageURL = info[.imageURL] as? URL else {
                LogError("Failed to get gif url")
                return false
            }
            
            if imageURL.pathExtension != "gif" {
                return false
            }
            
            guard let imageAsset = info[.phAsset] as? PHAsset else {
                LogError("Failed to get gif PHAsset")
                return false
            }
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            
            var success = false
            
            PHImageManager.default()
                .requestImageData(for: imageAsset, options: requestOptions) { data, _, _, info in
                    
                    guard let info = info else {
                        LogError("No PHImageManager info")
                        return
                    }
                    
                    if let error = info[PHImageErrorKey] as? Error {
                        LogError(error)
                        return
                    } else {
                        
                        if let isInCould = info[PHImageResultIsInCloudKey] as? Bool, isInCould {
                            LogError("Cannot fetch data from cloud. Option for network access not set.")
                            return
                        }
                        
                        if !Media.hasGif { LogError() }
                        
                        Media.gifCompletion?(data, nil)
                        Media.clearCompletions()
                        
                        topmostController.dismiss()
                        
                        success = true
                    }
            }
            
            return success
            
        }
        else {
            return false
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if extractGif(picker, info: info) {
            return
        }
        
        if var image = info[.originalImage] as? UIImage {
            
            if let edited = info[.editedImage] as? UIImage {
                image = edited
            }
            
            if !Media.hasPhoto { LogError() }
            
            image = image.withoutRotation
            
            Media.photoCompletion?(image)
            Media.gifCompletion?(nil, image)
            Media.universalCompletion?(image, nil)
            Media.clearCompletions()
            
            topmostController.dismiss()
            return
        }
        
        if let videoURL = info[.mediaURL] as? URL {
            
            if !Media.hasVideo { LogError() }
            
            Media.videoCompletion?(videoURL)
            Media.universalCompletion?(nil, videoURL)
            Media.clearCompletions()
            
            topmostController.dismiss()
            return
        }
        
        LogError()
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Media.clearCompletions()
        topmostController.dismiss()
    }
    
    //MARK: Dialog
    
    private static func setDialog() {
        
        photoDialog = UIAlertController(title: pickTitle, message: nil, preferredStyle: .actionSheet)
        
        if Media.hasPhoto {
            
            photoDialog.addAction(UIAlertAction(title: pickImageFromGalleryCaption, style: .default) { _ in Media.pickPhoto() })
            photoDialog.addAction(UIAlertAction(title: takePhotoCaption, style: .default)            { _ in Media.takePhoto() })
        }
        
        if Media.hasVideo {
            
            photoDialog.addAction(UIAlertAction(title: pickVideoFromGalleryCaption, style: .default) { _ in Media.pickVideo()   })
            photoDialog.addAction(UIAlertAction(title: recordVideoCaption, style: .default)          { _ in Media.recordVideo() })
        }
        
        photoDialog.addAction(UIAlertAction(title: cancelCaption, style: .cancel) { _ in clearCompletions() })
        
    }
}

#endif



