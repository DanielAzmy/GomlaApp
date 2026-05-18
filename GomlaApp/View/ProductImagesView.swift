//
//  ProductImagesView.swift
//  GomlaApp
//
//  Created by Daniel azmy on 18/05/2026.
//

import UIKit

class ProductImagesView: UIView {
    
    // MARK: - Properties
    private var images: [String] = []
    private var currentPage = 0
    private var shouldShowTag: Bool = false
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        cv.register(ProductImageCell.self, forCellWithReuseIdentifier: ProductImageCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .systemGray4
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return pc
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(images: [String], tag: Bool) {
        self.images = images
        self.shouldShowTag = tag
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        collectionView.reloadData()
    }
    
    // MARK: - Layout
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.visibleItemsInvalidationHandler = { [weak self] _, offset, environment in
            guard let self else { return }
            let page = Int((offset.x / environment.container.contentSize.width * CGFloat(self.images.count)).rounded())
            let clamped = max(0, min(page, self.images.count - 1))
            if self.currentPage != clamped {
                self.currentPage = clamped
                self.pageControl.currentPage = clamped
            }
        }
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubview(collectionView)
        addSubview(pageControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -8),
            
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

// MARK: - DataSource
extension ProductImagesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductImageCell.identifier,
            for: indexPath
        ) as! ProductImageCell
        cell.configure(imageUrl: images[indexPath.item], tag: shouldShowTag)
        return cell
    }
}
