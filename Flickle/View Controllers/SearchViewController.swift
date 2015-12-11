//
//  SearchViewController.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import UIKit
import WTAHelpers

class SearchViewController: UIViewController {

    let searchField = UITextField()
    var searchFieldVerticalConstraint: NSLayoutConstraint?
    var keyboardRect: CGRect? {
        didSet {
            if let rect = keyboardRect {
                // make sure the text field is not hidden by the keyboard
                searchFieldVerticalConstraint?.constant = min(0, -(rect.size.height - view.frame.size.height / 2) - 40)
            } else {
                searchFieldVerticalConstraint?.constant = 0
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        // color background around search text field
        let searchBg = UIView()
        searchBg.translatesAutoresizingMaskIntoConstraints = false
        searchBg.backgroundColor = UIColor.flk_logoBlueColor()
        view.addSubview(searchBg)
        searchFieldVerticalConstraint = searchBg.wta_addVerticallyCenterConstraintToSuperview()
        searchBg.wta_addHorizontallyCenterConstraintToSuperview()
        searchBg.wta_addLeadingConstraintToSuperviewOffset(10)
        searchBg.wta_addTrailingConstraintToSuperviewOffset(10)

        // search text field
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.backgroundColor = UIColor.whiteColor()
        searchField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0) // text inset hack
        searchBg.addSubview(searchField)
        let margin: CGFloat = 0.5
        searchField.wta_addEdgeConstraintsToSuperview(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
        searchField.wta_addHeightConstraint(40)

        // logo
        let logo = UILabel()
        logo.attributedText = NSAttributedString.flk_logo(30)
        logo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logo)
        logo.wta_addConstraintPlacingViewAboveView(searchField, separation: 8)
        logo.wta_addHorizontallyCenterConstraintToSuperview()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        searchField.becomeFirstResponder()
    }

    func keyboardWillShow(notification: NSNotification) {
        keyboardRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
    }

    func keyboardWillHide(notification: NSNotification) {
        keyboardRect = nil
    }

}
