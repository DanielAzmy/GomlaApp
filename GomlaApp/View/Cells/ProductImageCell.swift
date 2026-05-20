//
//  ProductImageCell.swift
//  GomlaApp
//
//  Created by Daniel azmy on 18/05/2026.
//

import UIKit
import SDWebImage


// MARK: - Cell
class ProductImageCell: UICollectionViewCell {
    static let identifier = "ProductImageCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let tagView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 0.07, green: 0.69, blue: 0.55, alpha: 1)
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        return v
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(tagView)
        tagView.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            tagView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            tagView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            tagView.widthAnchor.constraint(equalToConstant: 48),
            tagView.heightAnchor.constraint(equalToConstant: 48),
            
            tagLabel.centerXAnchor.constraint(equalTo: tagView.centerXAnchor),
            tagLabel.centerYAnchor.constraint(equalTo: tagView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(imageUrl: String, tag: Bool? = false) {
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
        
        if let tag{
            tagLabel.text = "special Offer"
            tagView.isHidden = false
        } else {
            tagView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        tagView.isHidden = true
    }
}
