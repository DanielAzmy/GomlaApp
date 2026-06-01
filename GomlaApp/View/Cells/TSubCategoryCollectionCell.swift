//
//  OfferSubCategoryCollectionCell.swift
//  GomlaApp
//
//  Created by Daniel azmy on 24/05/2026.
//

import UIKit


class TSubCategoryCollectionCell: UICollectionViewCell {
    static let identifier = "TSubCategoryCollectionCell"
    
    // MARK: - Properties
    var viewModel: SubCategoryViewModel? {
        willSet {
            categoryName.text = newValue?.categoryName
            handleSeclectionAppearance(newValue?.isSelected ?? false)
        }
    }
    
    // MARK: - Views
    private let categoryName: UILabel = {
        let label = UILabel()
        label.textColor = .coreAppContentPrimary
        label.font = .p3
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupAppearance() {
        layer.borderColor = UIColor.coreAppBorderDefault.cgColor
        layer.cornerRadius = 16
        layer.borderWidth = 1
        clipsToBounds = true
    }
    
    private func setupSubViews() {
        contentView.addSubview(categoryName)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            categoryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            contentView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
        ])
    }
    
    private func handleSeclectionAppearance(_ isSelected: Bool) {
        if isSelected {
            backgroundColor = .foundationMainHalanPrimary
            categoryName.textColor = .coreAppBackgroundHalanLight1
            categoryName.font = .subTitle3
            return
        }
        backgroundColor = .coreAppBackgroundHalanLight1
        categoryName.textColor = .coreAppContentPrimary
        categoryName.font = .p3
    }
}
