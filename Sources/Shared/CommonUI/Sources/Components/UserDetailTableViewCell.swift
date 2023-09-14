//
//  UserDetailTableViewCell.swift
//  CommonUI
//
//  Created by Mohammad reza on 13.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import UIKit
import Entities
import CommonUtils
import Kingfisher

public final class UserDetailTableViewCell: UITableViewCell {
    
    private var cardViewHeight: NSLayoutConstraint? = nil
    private let cardView: UIView = {
       let view = UIView()
        view.backgroundColor = CommonUIAsset.containerSecondary.color
        view.layer.cornerRadius = CommonUtilsConstants.Sizes.normalCornerRadius
        view.layer.masksToBounds = false
        view.layer.borderWidth = CommonUtilsConstants.Sizes.verticalMediumSpacing / 2
        view.layer.borderColor = CommonUIAsset.actionPrimary.color.cgColor
        return view
    }()
    
    private let photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = CommonUtilsConstants.Sizes.horizontalMediumSpacing
        return stackView
    }()
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CommonUtilsConstants.Sizes.normalCornerRadius
        imageView.layer.masksToBounds = true
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private let userAttributesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = CommonUtilsConstants.Sizes.verticalMediumSpacing
        return stackView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = CommonUIAsset.contentPrimary.color
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private let userEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = CommonUIAsset.contentPrimary.color
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.tintColor = CommonUIAsset.actionPrimary.color
        button.setTitleColor(CommonUIAsset.actionPrimary.color, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitle(CommonUtilsStrings.Generic.Bookmark.Add.title, for: .normal)
        return button
    }()
    
    
    public var user: User? = nil {
        didSet {
            guard let user else { return }
            userNameLabel.text = user.name.fullName
            userEmailLabel.text = user.email
            userPhotoImageView.kf.setImage(with: URL(string: user.picture.medium))
        }
    }
    
    public var isBookmarked: Bool = false {
        didSet {
            cardView.backgroundColor = isBookmarked ? CommonUIAsset.actionSecondary.color : CommonUIAsset.containerSecondary.color
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        cardView.add(toView: contentView)
            .disableAutoresizingMaskIntoConstraints()
            .horizontal(toConstraint: contentView.centerXAnchor)
            .width(toConstraint: contentView.widthAnchor, constant: -CommonUtilsConstants.Sizes.horizontalPadding * 2)
            .top(toConstraint: contentView.topAnchor, constant: CommonUtilsConstants.Sizes.verticalNormalSpacing)
        contentView.bottom(toConstraint: cardView.bottomAnchor, constant:   CommonUtilsConstants.Sizes.verticalNormalSpacing)

        photoStackView.add(toView: cardView)
            .disableAutoresizingMaskIntoConstraints()
            .horizontal(toConstraint: cardView.centerXAnchor)
            .width(toConstraint: cardView.widthAnchor, constant: -CommonUtilsConstants.Sizes.horizontalMediumSpacing * 2)
            .top(toConstraint: cardView.topAnchor, constant: CommonUtilsConstants.Sizes.verticalMediumSpacing)
        cardView.bottom(toConstraint: photoStackView.bottomAnchor, constant:   CommonUtilsConstants.Sizes.verticalMediumSpacing)
        
        photoStackView.addArrangedSubview(userPhotoImageView)
        userPhotoImageView.disableAutoresizingMaskIntoConstraints()
            .width(toConstraint: userPhotoImageView.heightAnchor)
        
        photoStackView.addArrangedSubview(userAttributesStackView)
        userAttributesStackView.addArrangedSubview(userNameLabel)
        userAttributesStackView.addArrangedSubview(userEmailLabel)
        userAttributesStackView.addArrangedSubview(bookmarkButton)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        cardViewHeight?.isActive = true
        cardViewHeight?.constant = 100
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cardView.layer.borderColor = CommonUIAsset.actionPrimary.color.cgColor
    }
}
