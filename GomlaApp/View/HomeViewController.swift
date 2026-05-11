//
//  ViewController.swift
//  GomlaApp
//
//  Created by Daniel azmy on 06/05/2026.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Variables
    var dataSource: UICollectionViewDiffableDataSource<HomeViewsSections, ItemModel>!
    var vm = HomeViewModel()
    
    //MARK: - UI components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .baseBackground 
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupCollectionView()
        setupDataSource()
        updateDataSource()
    }
    
    //MARK: - View Functions
    private func setupView(){
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        
        collectionView.register(ViewAllHomeHeaderView.self, forSupplementaryViewOfKind: ViewAllHomeHeaderView.self.description(), withReuseIdentifier: ViewAllHomeHeaderView.self.description())
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
        updateDataSource()
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
            if kind == ViewAllHomeHeaderView.self.description(){
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ViewAllHomeHeaderView.self.description(), for: indexPath) as! ViewAllHomeHeaderView
                cell.configure(title: "Explore Offers")
                return cell
            }
            return UICollectionReusableView()
        }
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
