//
//  ViewAllHomeHeaderView.swift
//  GomlaApp
//
//  Created by Daniel azmy on 06/05/2026.
//

import UIKit

class ViewAllHomeHeaderView: UICollectionReusableView {
    
    //MARK: - UI components
    private var headerTitle: UILabel = {
       let label = UILabel()
        label.font = .h3
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupView(){
        addSubview(headerTitle)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            headerTitle.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    //MARK: - Configuration
    func configure(title: String){
        headerTitle.text = title
    }
}
