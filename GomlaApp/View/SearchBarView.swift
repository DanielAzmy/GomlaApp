//
//  SearchBarView.swift
//  GomlaApp
//
//  Created by Daniel azmy on 12/05/2026.
//

import UIKit

class SearchBarView: UIView {

    private var textFieldContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .coreAppBackgroundHalanLight1
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var textField: UITextField = {
        let text = UITextField()
        text.placeholder = "Search at gomla..."
        text.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        imageView.frame = CGRect(x: 12, y: 0, width: 20, height: 20)
        
        containerView.addSubview(imageView)
        
        text.leftView = containerView
        text.leftViewMode = .always
        
        return text
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
        addSubview(textFieldContainer)
        textFieldContainer.addSubview(textField)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            textFieldContainer.topAnchor.constraint(equalTo: topAnchor),
            textFieldContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 4),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -4),
            textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -4),
        ])
    }

}
