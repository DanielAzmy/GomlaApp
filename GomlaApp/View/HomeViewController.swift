//
//  ViewController.swift
//  GomlaApp
//
//  Created by Daniel azmy on 06/05/2026.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showHomeData(_ data: homeDataModel)
    func showError(_ error: String)
}

class HomeViewController: UIViewController {
   
    //MARK: - Variables
    var dataSource: UICollectionViewDiffableDataSource<HomeViewsSections, ItemModel>!
    var vm = HomeViewModel()
    var presenter: HomePresenter!
    
    //MARK: - UI components
    private var searchBar: SearchBarView = {
        let view = SearchBarView()
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
//        updateDataSource()
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
                case .spceialItems:
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
                case .catgories:
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
                case .bestSeller:
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

        header.pinToVisibleBounds = true

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


extension HomeViewController{
    private func setupDataSource(){
        creatDataSource()
//        updateDataSource()
    }
    
    private func creatDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item{
            case .banner(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerViewCell.self.description(), for: indexPath) as! HomeBannerViewCell
                cell.configure(image: model.imageUrl)
                return cell
            case .specialItem(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCell.self.description(), for: indexPath) as! HomeItemCell
                cell.configure(model: model)
                return cell
            case .category(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.self.description(), for: indexPath) as! HomeCategoryCell
                cell.configure(model: model)
                return cell
            case .bestSeller(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCell.self.description(), for: indexPath) as! HomeItemCell
                cell.configure(model: model)
                return cell
            }
        })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                    guard kind == UICollectionView.elementKindSectionHeader else {
                        return UICollectionReusableView()
                    }
                    let header = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: ViewAllHomeHeaderView.self.description(),
                        for: indexPath
                    ) as! ViewAllHomeHeaderView
                    
                    guard let section = self.dataSource.sectionIdentifier(for: indexPath.section) else {
                        return header
                    }
                    switch section {
                    case .banner:       header.configure(title: "")
                    case .spceialItems: header.configure(title: "Special Offers")
                    case .catgories:   header.configure(title: "Categories")
                    case .bestSeller:   header.configure(title: "Best Sellers")
                    }
                    return header
                }
    }
    
    func updateCategories(_ categories: [CategoryModel]) {

        var snapshot = dataSource.snapshot()

//        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .catgories))

        snapshot.appendSections([.catgories])
        let newItems = categories.map { ItemModel.category($0) }
        snapshot.appendItems(newItems, toSection: .catgories)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func updateItems(_ categories: [Product]) {

        var snapshot = dataSource.snapshot()

        if !snapshot.sectionIdentifiers.contains(.spceialItems) {
            snapshot.appendSections([.spceialItems])
        }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .spceialItems))

        let uniqueItems = Array(
            Dictionary(
                grouping: categories,
                by: { $0.id }
            ).compactMap { $0.value.first }
        )

        let newItems = uniqueItems.map { ItemModel.specialItem($0) }

        snapshot.appendItems(newItems, toSection: .spceialItems)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateDataSource() {
            var snapshot = NSDiffableDataSourceSnapshot<HomeViewsSections, ItemModel>()
            
        snapshot.appendSections([.banner, .spceialItems, .catgories, .bestSeller])
            
        snapshot.appendItems(vm.banners.map { .banner($0) }, toSection: .banner)
        snapshot.appendItems(vm.specialItems.map { .specialItem($0) }, toSection: .spceialItems)
        snapshot.appendItems(vm.categories.map { .category($0) }, toSection: .catgories)
        snapshot.appendItems(vm.specialItems.map { .bestSeller($0) }, toSection: .bestSeller)
            
            dataSource.apply(snapshot, animatingDifferences: false)
        }
}

extension HomeViewController: HomeViewProtocol{
    func showHomeData(_ data: homeDataModel) {
        updateCategories(data.categories)
        updateItems(data.sections.first?.items.products ?? [])
    }
    
    func showError(_ error: String) {}
    
   
}
