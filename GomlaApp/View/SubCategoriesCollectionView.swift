//
//  TSubCategoriesCollectionView.swift
//  GomlaApp
//
//  Created by Daniel azmy on 24/05/2026.
//

import UIKit


protocol TSubCategoriesCollectionViewDelegate: AnyObject {
    func didSelectSubCategory(with id: String?, title: String?)
}


final class SubCategoriesCollectionView: UIView {
    
    // MARK: - Properties
    var viewModels: [SubCategoryViewModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate: TSubCategoriesCollectionViewDelegate?
    
    // MARK: - UI components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        registerCells()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(collectionView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func registerCells() {
        collectionView.register(TSubCategoryCollectionCell.self, forCellWithReuseIdentifier: TSubCategoryCollectionCell.identifier)
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension SubCategoriesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSubCategoryCollectionCell.identifier, for: indexPath) as! TSubCategoryCollectionCell
        cell.viewModel = viewModels?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModels?.forEach { $0.isSelected = false }
        viewModels?[indexPath.item].isSelected = true
        let subCategoryId = viewModels?[indexPath.item].subCategoryId, subaCategoryTitle = viewModels?[indexPath.item].categoryName
        collectionView.reloadData()
        delegate?.didSelectSubCategory(with: subCategoryId, title: subaCategoryTitle)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 85, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
