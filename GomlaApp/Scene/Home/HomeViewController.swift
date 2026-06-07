//
//  ViewController.swift
//  GomlaApp
//
//  Created by Daniel azmy on 06/05/2026.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showHomeData(_ data: HomeDataModel)
    func showError(_ error: String)
}

class HomeViewController: UIViewController {
    
    //MARK: - Variables
    var dataSource: UICollectionViewDiffableDataSource<HomeViewsSections, ItemModel>!
    var vm = HomeViewModel()
    var presenter: HomePresenter!
    
    //MARK: - UI components
    private var searchBar: SearchBarView = {
        let view = SearchBarView(placeholder: "Search at gomla...")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .baseBackground
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupCollectionView()
        setupDataSource()
        setupNavigationBar()
        presenter = HomePresenter(view: self)
        presenter.fetchHomeData()
    }
    
    //MARK: - View Functions
    private func setupView(){
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 45),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupCollectionView() {
        registerCells()
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(makeLayout(), animated: false)
    }
    
    private func registerCells(){
        collectionView.register(HomeBannerViewCell.self, forCellWithReuseIdentifier: HomeBannerViewCell.self.description())
        
        collectionView.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.self.description())
        
        collectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.self.description())
        
        collectionView.register(
            ViewAllHomeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ViewAllHomeHeaderView.self.description()
        )
    }
    
    private func setupNavigationBar() {
        title = "Gomla"
        
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


//MARK: - Compositional layout
extension HomeViewController{
    func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, env in
            guard let self,
                  let section = self.dataSource?.sectionIdentifier(for: sectionIndex) else {
                return self?.emptySection()
            }
            switch section {
            case .banner:
                return self.createSection(
                    itemHeight: .absolute(200),
                    itemWidth: .fractionalWidth(1),
                    interItemSpacing: 12,
                    groupHeight: .absolute(200),
                    groupwidth: .fractionalWidth(0.9),
                    interGroupSpacing: 16,
                    sectionInsets: .init(top: 16, leading: 16, bottom: 16, trailing: 16),
                    scrollBehaviour: .groupPaging,
                    shouldShowHeader: false
                )
            case .sections:
                return self.createSection(
                    itemHeight: .fractionalHeight(1),
                    itemWidth: .absolute(187),
                    interItemSpacing: 11,
                    groupHeight: .absolute(300),
                    groupwidth: .fractionalWidth(1/2),
                    sectionInsets: .init(top: 8, leading: 11, bottom: 16, trailing: 11),
                    scrollBehaviour: .continuous,
                    shouldShowHeader: true
                )
            case .categories:
                return self.createSection(
                    itemHeight: .fractionalHeight(1),
                    itemWidth: .fractionalWidth(1 / 3),
                    itemCount: 3,
                    interItemSpacing: 0,
                    groupHeight: .fractionalWidth(0.42),
                    groupwidth: .fractionalWidth(1),
                    interGroupSpacing: 4,
                    sectionInsets: .init(top: 8, leading: 12, bottom: 16, trailing: 12),
                    scrollBehaviour: .none,
                    shouldShowHeader: true
                )
            }
        }
    }
    
    private func createSection(
        itemHeight: NSCollectionLayoutDimension,
        itemWidth: NSCollectionLayoutDimension,
        itemCount: Int = 1,
        interItemSpacing: Double = 0,
        groupHeight: NSCollectionLayoutDimension,
        groupwidth: NSCollectionLayoutDimension,
        interGroupSpacing: Double = 0,
        sectionInsets: NSDirectionalEdgeInsets = .zero,
        scrollBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none,
        shouldShowHeader: Bool = false
    ) -> NSCollectionLayoutSection {
        
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: itemWidth,
            heightDimension: itemHeight
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 4,
            bottom: 4,
            trailing: 4
        )
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: groupwidth,
            heightDimension: groupHeight
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: itemCount
        )
        
        group.interItemSpacing = .fixed(interItemSpacing)
        
        // header
        let headrSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(32)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headrSize,
            elementKind: ViewAllHomeHeaderView.self.description(),
            alignment: .topLeading
        )
        
        header.pinToVisibleBounds = false
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = scrollBehaviour
        section.interGroupSpacing = interGroupSpacing
        section.contentInsets = sectionInsets
        
        if shouldShowHeader {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(40)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            header.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [header]
        }
        
        return section
    }
    
    private func emptySection(height: CGFloat = 0) -> NSCollectionLayoutSection {
        return  createSection(itemHeight: .fractionalWidth(1),
                              itemWidth: .absolute(height),
                              groupHeight: .fractionalWidth(1),
                              groupwidth: .absolute(height))
    }
}

extension HomeViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        switch item {
        case .banner(let bannerModel):
            print(bannerModel.id)
        case .category(let categoryModel):
            let vc = CategoryBuilder.build(category: categoryModel)
            navigationController?.pushViewController(vc, animated: true)
        case .product(let product):
            let vc = ProductDetailsViewController(item: product)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension HomeViewController{
    private func setupDataSource(){
        creatDataSource()
    }
    
    private func creatDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item{
            case .banner(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerViewCell.self.description(), for: indexPath) as! HomeBannerViewCell
                cell.configure(image: model.imageUrl)
                return cell
            case .product(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCell.self.description(), for: indexPath) as! HomeItemCell
                cell.configure(model: model)
                return cell
            case .category(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.self.description(), for: indexPath) as! HomeCategoryCell
                cell.configure(model: model)
                return cell
            }
        })
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }
            
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ViewAllHomeHeaderView.self.description(),
                for: indexPath
            ) as! ViewAllHomeHeaderView
            
            guard let section = self?.dataSource.sectionIdentifier(for: indexPath.section) else {
                return header
            }
            
            switch section {
                
            case .banner:
                header.configure(title: "")
                
            case .categories:
                header.configure(title: "Categories")
                
            case .sections(let model):
                header.configure(title: model.nameEn)
            }
            return header
        }
    }
    
}

extension HomeViewController: HomeViewProtocol{
    func showHomeData(_ data: HomeDataModel) {
        
        /// snapshot is the current state of CollectionView
    
        /// Diffable datasource compares:
        /// old snapshot
        /// new snapshot

        ///Then automatically calculates:
        /// insertions
        /// deletions
        /// moves
        /// reloads
        
        /// A snapshot contains:
        /// Sections of "HomeViewsSections"
        /// Items inside sections of "ItemModel"
        
        var snapshot = NSDiffableDataSourceSnapshot<HomeViewsSections, ItemModel>()
        
        // MARK: - Banner
        
        if !data.banners.isEmpty {
            
            /// here we append new section to collection view
            snapshot.appendSections([.banner])
            
            let banners = data.banners.map {
                ItemModel.banner($0)
            }
            
            /// here we append items to section that we add previuosly
            snapshot.appendItems(banners, toSection: .banner)
        }
        
        // MARK: - first Section (top picks)
        if let firstSection = data.sections.first {

            let firstSectionId = HomeViewsSections.sections(firstSection)

            snapshot.appendSections([firstSectionId])
            snapshot.appendItems(
                firstSection.items.products.removeDuplicates().map { .product($0) },
                toSection: firstSectionId
            )
        }
        
        // MARK: - Categories
        
        if !data.categories.isEmpty {
            
            snapshot.appendSections([.categories])
            
            let categories = data.categories.map {
                ItemModel.category($0)
            }
            
            snapshot.appendItems(categories, toSection: .categories)
        }
        
        // MARK: - Sections
        
        data.sections.dropFirst().forEach { section in
            
            let sectionType = HomeViewsSections.sections(section)
            
            snapshot.appendSections([sectionType])
            
            let products = section.items.products
                .removeDuplicates()
                .map {
                    ItemModel.product($0)
                }
            
            snapshot.appendItems(products, toSection: sectionType)
        }
        
        /// here finaly we apply all changes that we made to snapshot 
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func showError(_ error: String) {}
    
    
}
