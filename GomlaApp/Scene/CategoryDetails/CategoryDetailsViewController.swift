//
//  CategoryDetailsViewController.swift
//  GomlaApp
//
//  Created by Daniel azmy on 24/05/2026.
//

import UIKit

protocol CategoryDetailsViewProtocol: AnyObject{
    func setCategories(with viewModel: SubCategoriesViewModel)
    func setCategoryProducts(with products: [Product])
}

class CategoryDetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    private var viewModel: SubCategoriesViewModel? {
        didSet {
            subCategoryCollectionView.viewModels = viewModel?.viewModels
            interactor?.getProducs(id: viewModel?.viewModels.first?.subCategoryId ?? "")
        }
    }
    
    // MARK: - Public properties
    var category: CategoryModel
    var dataSource: UICollectionViewDiffableDataSource<CategoryDetailsSections, ItemModel>!
    
    // MARK: - Dependencies
    var interactor: CategoryUseCaseProtocol?
    var presenter: CategoryPresenterProtocol?
    var router: CategoryRouterProtocol?
    
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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .baseBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
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
    
    init(category: CategoryModel) {
        self.category = category
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
        subCategoryCollectionView.delegate = self
        assignCollectionViewDelegates()
        registerCells()
        createDataSource()
        collectionView.setCollectionViewLayout(makeLayout(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getProducData(id: category.id)
    }
    
    //MARK: - functions
    private func setupView(){
        view.addSubview(searchStack)
        view.addSubview(subCategoryCollectionView)
        view.addSubview(collectionView)
        view.backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            searchStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchStack.heightAnchor.constraint(equalToConstant: 40),
            
            allCategoriesButton.widthAnchor.constraint(equalToConstant: 40),
            
            subCategoryCollectionView.topAnchor.constraint(equalTo: searchStack.bottomAnchor, constant: 8),
            subCategoryCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            subCategoryCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            subCategoryCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: subCategoryCollectionView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func assignCollectionViewDelegates(){
        collectionView.delegate = self
    }
    
    private func registerCells(){
        collectionView.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.self.description())
        collectionView.register(
            ViewAllHomeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ViewAllHomeHeaderView.self.description()
        )
    }
    
    private func createDataSource(){
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
            case .products:
                header.configure(title: "")
            }
            return header
        }
    }
    
    private func setupNavigationBar() {
        title = category.name
        
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

extension CategoryDetailsViewController: CategoryDetailsViewProtocol{
    func setCategoryProducts(with products: [Product]) {
        var snapshot = NSDiffableDataSourceSnapshot<CategoryDetailsSections, ItemModel>()

        snapshot.appendSections([.products])

        let items = products.map {
            ItemModel.product($0)
        }

        snapshot.appendItems(items, toSection: .products)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func setCategories(with viewModel: SubCategoriesViewModel) {
        self.viewModel = viewModel
        self.subCategoryCollectionView.selectFirst()
        self.subCategoryCollectionView.reloadInputViews()
    }
}

extension CategoryDetailsViewController: TSubCategoriesCollectionViewDelegate{
    func didSelectSubCategory(with id: String?, title: String?) {
        guard let id else { return }
        interactor?.getProducs(id: id)
        collectionView.reloadData()
    }
}

extension CategoryDetailsViewController: UICollectionViewDelegate{
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

//MARK: - Compositional layout
extension CategoryDetailsViewController{
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
            case .products:
                return self.createSection(
                    itemHeight: .fractionalHeight(1),
                    itemWidth: .absolute(187),
                    itemCount: 2,
                    groupHeight: .absolute(300),
                    groupwidth: .fractionalWidth(1/2),
                    sectionInsets: .init(top: 8, leading: 11, bottom: 16, trailing: 11),
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
