//
//  HomeBannerViewCell.swift
//  GomlaApp
//
//  Created by Daniel azmy on 06/05/2026.
//

import UIKit
import SDWebImage


class HomeBannerViewCell: UICollectionViewCell {
    
    //MARK: - UI components
    private var bannerImage: UIImageView = {
       let bi = UIImageView()
        bi.contentMode = .scaleAspectFill
        bi.clipsToBounds = true
        bi.translatesAutoresizingMaskIntoConstraints = false
        return bi
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
        contentView.addSubview(bannerImage)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func setupSubViewes(){
        bannerImage.layer.cornerRadius = 16
    }
    
    //MARK: - Configuration
    func configure(image: String){
        let url = URL(string: image)
        bannerImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
    }
}
