//
//  Utilities.swift
//  KrishnaVideoPlayer
//
//  Created by Krishnarjun Banoth on 02/02/20.
//  Copyright © 2020 Krishnarjun Banoth. All rights reserved.
//

import Foundation
import UIKit

class SFUIAttributedText : NSObject {
    
    
    //SF UI Display Medium
    class func boldAttributedTextForString(_ string: String, size: CGFloat, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: boldAttributesForSize(size, color: color))
    }
    class func boldAttributesForSize(_ size: CGFloat, color: UIColor) -> [NSAttributedString.Key : Any] {
        
        let font = UIFont.boldSystemFont(ofSize: size)
        let attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
        
        return attributes
    }
}
