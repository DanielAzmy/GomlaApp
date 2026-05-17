//
//  HomeItemCell.swift
//  GomlaApp
//
//  Created by Daniel azmy on 10/05/2026.
//

import UIKit
import SDWebImage

class HomeItemCell: UICollectionViewCell {
    
    //MARK: - UI components
    private var itemImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var itemName: UILabel = {
        let label = UILabel()
        label.font = .p3
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var itemSize: UILabel = {
        let label = UILabel()
        label.font = .p3
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var sellingUnitContainer: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 0.6
        view.layer.borderColor = UIColor.coreAppBorderDefault.cgColor
        view.backgroundColor = .coreAppBackgroundHalanLight2
        return view
    }()
    
    private var spacerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var unitStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sellingUnitContainer, spacerView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var sellingUnit: UILabel = {
       let label = UILabel()
        label.font = .caption3
        label.textColor = .foundationMainHalanPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var amount: UILabel = {
       let label = UILabel()
        label.font = .navigationTitle
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var discountAmount: UILabel = {
        let label = UILabel()
        label.font = .navTab
        label.textColor = .black.withAlphaComponent(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [amount, discountAmount])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var addToCartButton = PrimaryButton(title: "Add To Cart")
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemImage, itemName, itemSize, unitStack, amountStack, addToCartButton])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.setCustomSpacing(10, after: unitStack)
        stack.setCustomSpacing(8, after: itemImage)
        stack.setCustomSpacing(10, after: amountStack)
        stack.setCustomSpacing(6, after: itemSize)
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
        contentView.addSubview(sellingUnit)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            sellingUnit.topAnchor.constraint(equalTo: sellingUnitContainer.topAnchor, constant: 4),
            sellingUnit.centerYAnchor.constraint(equalTo: sellingUnitContainer.centerYAnchor),
            sellingUnit.bottomAnchor.constraint(equalTo: sellingUnitContainer.bottomAnchor, constant: -6),
            sellingUnit.centerXAnchor.constraint(equalTo: sellingUnitContainer.centerXAnchor),
            
            sellingUnitContainer.heightAnchor.constraint(equalToConstant: 32),
            
            itemImage.heightAnchor.constraint(equalToConstant: 110),
            
            addToCartButton.heightAnchor.constraint(equalToConstant: 40),
            
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
    
    func setDiscountAmount(_ amount: String) {
        let attributedString = NSMutableAttributedString(string: amount)
        attributedString.addAttribute(
            .strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        discountAmount.attributedText = attributedString
    }
    
    //MARK: - Configuration
    func configure(model: Product ){
        let url = URL(string: model.imageUrl)
        itemImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        itemName.text = model.title
        if let size = model.size{
            itemSize.text = size
        }
        
        sellingUnit.text = model.sellingUnit
        
        amount.text = String("\(model.price) EGP")
        setDiscountAmount("\(model.discount) EGP")
    }
}
