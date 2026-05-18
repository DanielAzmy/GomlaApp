//
//  Extensions.swift
//  GomlaApp
//
//  Created by Daniel azmy on 06/05/2026.
//

import UIKit

public extension UIColor{
    class var baseBackground: UIColor {
        return UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1.00)
    }
    
    class var coreAppBorderDefault: UIColor {
        return UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
    }
    
    class var coreAppBackgroundHalanLight2: UIColor {
        return UIColor(red: 0.92, green: 0.97, blue: 0.96, alpha: 1.00)
    }
    
    class var foundationMainHalanPrimary: UIColor {
        return UIColor(red: 0.00, green: 0.66, blue: 0.44, alpha: 1.00)
    }
    
    class var coreAppBackgroundHalanLight1: UIColor {
        return UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1.00)
    }
    
    class var coreAppContentSecondary: UIColor {
        return UIColor(red: 0.37, green: 0.38, blue: 0.38, alpha: 1.00)
    }
    
    class var coreAppBorderSeperator: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    }
}


class PrimaryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupButton(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = .button1
        setTitleColor(.white, for: .normal)
        backgroundColor = .foundationMainHalanPrimary
        layer.cornerRadius = 14
        heightAnchor.constraint(equalToConstant: 54).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Press animation
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            self.alpha = 0.9
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.alpha = 1
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.alpha = 1
        }
    }
}

extension Array where Element == Product {

    func removeDuplicates() -> [Product] {

        var seen = Set<String>()

        return filter {
            seen.insert($0.id).inserted
        }
    }
}
