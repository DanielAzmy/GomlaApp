//
//  ProductDetailsViewController.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//

import UIKit

protocol ProductDetailsView: AnyObject {
    func setProductData(with item: ProductDetailsModel)
}

class ProductDetailsViewController: UIViewController {
    
    var item: Product
    private var presenter: ProductDetailsPresenter!
    
    //MARK: - UI components
    private let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryTitle: UILabel = {
        let label = UILabel()
        label.font = .p1
        label.textColor = .foundationMainHalanPrimary
        label.numberOfLines = 1
        label.text = "category"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.font = .h4
        label.textColor = .black
        label.numberOfLines = 2
        label.text = "Name of product"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private var productImages: ProductImagesView = {
       let view = ProductImagesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.font = .h2
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "500"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let discount: UILabel = {
        let label = UILabel()
        label.font = .h4
        label.textColor = .coreAppContentSecondary
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private lazy var amountStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [price, discount])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let discreptionTitle: UILabel = {
        let label = UILabel()
        label.font = .h4
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let discreption: UILabel = {
        let label = UILabel()
        label.font = .h4
        label.textColor = .coreAppContentSecondary
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private var contactView: SupportView = {
       let view = SupportView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            categoryTitle,
            productName,
            productImages,
            amountStack,
            discreptionTitle,
            discreption,
            contactView
        ])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var addToCartButton = PrimaryButton(title: "Add To Cart")
    
    init(item: Product) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavigationBar()
        presenter = ProductDetailsPresenter(view: self, id: item.id)
        presenter.fetchProductData()
    }
    
    //MARK: - functions
    
    private func setupView(){
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        view.addSubview(addToCartButton)
        mainStack.insertArrangedSubview(makeDivider(), at: 4)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant:  -16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -24),
            mainStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32),
            
            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addToCartButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 16),
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            productImages.heightAnchor.constraint(equalToConstant: 400),
            
            contactView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func makeDivider(color: UIColor = .coreAppBorderSeperator, height: CGFloat = 1) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: height).isActive = true
        return divider
    }
    
    func setDiscountAmount(_ amount: String) {
        let attributedString = NSMutableAttributedString(string: amount)
        attributedString.addAttribute(
            .strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        discount.attributedText = attributedString
    }
    
    private func setupNavigationBar() {
        title = "Details"
        
        let trailingButton = UIBarButtonItem(
            image: UIImage(resource: .cart),
            style: .plain,
            target: self,
            action: #selector(didTapCart)
        )
        
        navigationItem.rightBarButtonItem = trailingButton
    }
    
    @objc private func didTapCart() {
        print("Cart tapped")
    }
}

extension ProductDetailsViewController: ProductDetailsView {
    func setProductData(with item: ProductDetailsModel) {
        self.productName.text = item.nameEn
        self.price.text = String(item.price)
        productImages.configure(images: item.images, tag: item.isProductHasCfOffer)
        discreptionTitle.text = "Product description"
        discreption.text = item.descriptionEn
        if item.discount > 0 {
            setDiscountAmount(String(item.discount))
        }
    }
    
}
