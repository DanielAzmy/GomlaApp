//
//  HomeCategoryCell.swift
//  GomlaApp
//
//  Created by Daniel azmy on 11/05/2026.
//

import UIKit
import SDWebImage

class HomeCategoryCell: UICollectionViewCell {
    //MARK: - UI components
    private var categoryImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .foundationMainHalanPrimary
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var categoryTitle: UILabel = {
       let label = UILabel()
        label.font = .subTitle3
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [categoryImage, categoryTitle])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupSubViewes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupView(){
        contentView.addSubview(mainStack)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            categoryImage.heightAnchor.constraint(equalToConstant: 80),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupSubViewes(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.coreAppBorderDefault.cgColor
    }
    
    //MARK: - Configuration
    func configure(model: CategoryModel){
        let url = URL(string: model.imageUrl)
        categoryImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        categoryTitle.text = model.name
    }
}
