//
//  PhotoTableViewCell.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import UIKit
import ReactiveCocoa

class PhotoTableViewCell: UITableViewCell {

    // MARK: Properties

    /// models
    var viewModel: PhotoViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            viewModel.photo.producer.startWithNext { [weak self] photo in
                self?.photoTitleLabel.text = photo.title
                self?.photoOwnerLabel.text = photo.ownerName
                self?.photoImageView.setImageWithURL(photo.url.square)
                self?.setNeedsLayout()
            }
        }
    }

    /// views
    var photoTitleLabel: UILabel!
    var photoImageView: UIImageView!
    var photoOwnerLabel: UILabel!
    var photoInfoStackView: UIStackView!

    // MARK: Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Instance Methods

    private func setup() {
        photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .ScaleAspectFit
        contentView.addSubview(photoImageView)

        photoInfoStackView = UIStackView()
        photoInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        photoInfoStackView.axis = .Vertical
        photoInfoStackView.spacing = 6
        contentView.addSubview(photoInfoStackView)

        photoTitleLabel = UILabel()
        photoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        photoInfoStackView.addArrangedSubview(photoTitleLabel)

        photoOwnerLabel = UILabel()
        photoOwnerLabel.translatesAutoresizingMaskIntoConstraints = false
        photoInfoStackView.addArrangedSubview(photoOwnerLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        photoImageView.wta_addLeadingConstraintToSuperviewOffset(8)
        photoImageView.wta_addVerticallyCenterConstraintToSuperview()
        photoImageView.wta_addHeightConstraint(60)
        photoImageView.wta_addWidthConstraint(60)

        photoInfoStackView.wta_addConstraintPlacingViewRightOfView(photoImageView, separation: 8)
        photoInfoStackView.wta_addTopConstraintToSuperviewOffset(10)
        photoInfoStackView.wta_addBottomConstraintToSuperviewOffset(10)
        photoInfoStackView.wta_addTrailingConstraintToSuperviewOffset(0)
        photoInfoStackView.addConstraint(NSLayoutConstraint(item: photoInfoStackView, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 65))
    }

}
