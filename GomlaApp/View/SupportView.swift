//
//  SupportView.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//


import UIKit

final class SupportView: UIView{
    
    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = 12
        return container
    }()
    
    
    private let problemLabel: UILabel = {
        let label = UILabel()
        label.text = "فى حالة انك توجه مشكلة"
        label.font = .subTitle2
        label.textColor = .secondaryLabel
        return label
    }()
    
//    
    private lazy var supportButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.titleLabel?.text = "text"
        return button
    }()
    
    private lazy var needHelpStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [supportButton, problemLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupView() {
        addSubview(container)
        container.addSubview(needHelpStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            needHelpStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            needHelpStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            needHelpStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            needHelpStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
        ])
    }
}


