//
//  CategoryDetailsViewController.swift
//  GomlaApp
//
//  Created by Daniel azmy on 24/05/2026.
//

import UIKit

class CategoryDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: SubCategoriesViewModel = SubCategoriesViewModel(categories: [CategoryEntity (
        id: "0",
        nameEn: "sub1",
        nameAr: "",
        image: nil,
        childrenType: nil), CategoryEntity (
            id: "1",
            nameEn: "subfhlakjf2",
            nameAr: "",
            image: nil,
            childrenType: nil),
                                                                                        
    ])
    
    // MARK: - UI components
    private let searchBar: SearchBarView = {
        let view = SearchBarView(placeholder: "Search in ...")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let allCategoriesButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(resource: .cat), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .baseBackground
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let subCategoryCollectionView: SubCategoriesCollectionView = {
        let view = SubCategoriesCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchBar, allCategoriesButton])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillProportionally
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavigationBar()
        subCategoryCollectionView.viewModels = viewModel.viewModels
    }
    
    //MARK: - functions
    private func setupView(){
        view.addSubview(searchStack)
        view.addSubview(subCategoryCollectionView)
        view.backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            searchStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchStack.heightAnchor.constraint(equalToConstant: 40),
            
            allCategoriesButton.widthAnchor.constraint(equalToConstant: 40),
            
            subCategoryCollectionView.topAnchor.constraint(equalTo: searchStack.bottomAnchor, constant: 16),
            subCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            subCategoryCollectionView.heightAnchor.constraint(equalToConstant: 40),
        ])
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
