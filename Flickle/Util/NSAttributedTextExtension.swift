//
//  NSAttributedTextExtension.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import Foundation
import UIKit

let FlickleFontWeight = UIFontWeightUltraLight

extension NSAttributedString {

    class func flk_logo(fontSize: CGFloat) -> NSAttributedString {
        let name = NSBundle.mainBundle().infoDictionary?["CFBundleDisplayName"] as? String ?? "Flickle"
        let text = NSMutableAttributedString(string: name)
        let colorPattern: [UIColor] = [
            .flk_logoBlueColor(),
            .flk_logoRedColor(),
            .flk_logoYellowColor(),
            .flk_logoGreenColor()
        ]

        for i in 0..<name.characters.count {
            let colorIndex = i >= colorPattern.count ? i - colorPattern.count : i
            text.addAttribute(NSForegroundColorAttributeName, value: colorPattern[colorIndex], range: NSRange(location: i, length: 1))
        }

        text.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(fontSize, weight: FlickleFontWeight), range: NSRange(location: 0, length: name.characters.count))

        return NSAttributedString(attributedString: text)
    }

}