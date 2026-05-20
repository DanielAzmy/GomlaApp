//
//  SupportView.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//


import UIKit


final class SupportView: UIView {

    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = 12
        container.layer.borderColor = UIColor.coreAppBorderDefault.cgColor
        container.layer.borderWidth = 1
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let imageView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(resource: .support)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let problemLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact Us"
        label.font = .subTitle2
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Support", for: .normal)
        button.tintColor = .foundationMainHalanPrimary
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var needHelpStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            imageView,
            problemLabel,
            supportButton
        ])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.setCustomSpacing(60, after: problemLabel)
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupView() {
        backgroundColor = .clear

        addSubview(container)
        container.addSubview(needHelpStack)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            // Container
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Stack
            needHelpStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            needHelpStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            needHelpStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            needHelpStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            
            imageView.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
}

