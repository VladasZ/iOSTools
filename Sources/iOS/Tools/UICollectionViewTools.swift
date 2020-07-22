//
//  UICollectionViewTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 25/12/2017.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(iOS)
    
    import UIKit
        
    public extension UICollectionView {
        
        func getCell<T: UICollectionViewCell>(_ type: T.Type,
                                         indexPath: IndexPath,
                                         _ setup: ((T) -> ())? = nil) -> UICollectionViewCell {
            guard let cell: T = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
                else { LogError("No cell for identifier: \(T.identifier)"); return UICollectionViewCell() }
            setup?(cell)
            return cell
        }
    }
    
    public extension UICollectionViewCell {
        
        class var identifier: String { return String(describing: self) }
        
        class func registerFor(_ collectionView: UICollectionView) {
            collectionView.register(UINib(nibName: identifier, bundle: Bundle(for: self)), forCellWithReuseIdentifier: identifier)
        }
    }
    
#endif

