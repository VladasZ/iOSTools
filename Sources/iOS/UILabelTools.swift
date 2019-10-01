//
//  UILabelTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 4/28/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit
import SwiftyTools

public extension UILabel {
    
    var lineSpacing: CGFloat { get { LogWarning(); return 0 }
        set {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = newValue
            style.alignment = textAlignment
            attributedText = NSAttributedString(string: self.text ?? "",
                                                attributes: [NSAttributedString.Key.paragraphStyle : style])
        }
    }
    
    func rectForString(_ string: String) -> CGRect? {
        guard let nsText = text as NSString? else { return nil }
        let range = nsText.range(of: string)
        guard let rect = rectForCharacterRange(range: range) else { return nil }
        if rect.size.height == 0 || rect.size.width == 0 { return nil }
        return rect
    }
    
    func rectForCharacterRange(range: NSRange) -> CGRect? {
        guard let attributedText = attributedText else { return nil }
        var glyphRange = NSRange()
        let layoutManager = NSLayoutManager()
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        layoutManager.addTextContainer(textContainer)
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
    
    func appendImage(_ image: UIImage, bounds: CGRect? = nil) {
        let attachment = NSTextAttachment()
        attachment.image = image
        if let bounds = bounds { attachment.bounds = bounds }
        let attachmentString = NSAttributedString(attachment: attachment)
        let nameString = NSMutableAttributedString(string: "\(self.text ?? "") ")
        nameString.append(attachmentString)
        attributedText = nameString
    }
}

#endif
