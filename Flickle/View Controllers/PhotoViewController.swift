//
//  PhotoViewController.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/11/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    let viewModel: PhotoViewModel
    let scrollView = UIScrollView()
    let imageView = UIImageView()

    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.photo.value.title
        view.backgroundColor = UIColor.whiteColor()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.wta_addEdgeConstraintsToSuperview(UIEdgeInsetsZero)
        scrollView.addSubview(imageView)

        imageView.setImageWithURL(viewModel.photo.value.url.large, placeholder: nil, completionBlock: { (image) -> Void in
            self.scrollView.contentSize = image.size
            self.imageView.frame = CGRect(origin: CGPointZero, size: image.size)

            // set zoom scale

            let scrollViewFrame = self.scrollView.frame
            let scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width
            let scaleHeight = self.scrollView.frame.size.height / self.scrollView.contentSize.height
            let minScale = min(scaleWidth, scaleHeight)

            self.scrollView.minimumZoomScale = minScale
            self.scrollView.maximumZoomScale = 1.0
            self.scrollView.zoomScale = minScale
        }) { (request, response, error) -> Void in
                print("failure")
        }
    }

}

// MARK: - UIScrollViewDelegate
extension PhotoViewController: UIScrollViewDelegate {

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
