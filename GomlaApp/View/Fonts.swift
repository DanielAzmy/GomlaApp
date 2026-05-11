//
//  Fonts.swift
//  GomlaApp
//
//  Created by Daniel azmy on 11/05/2026.
//


import UIKit
import SwiftUI

public extension Font { init(_ uiFont: UIFont) { self = Font(uiFont as CTFont) } }

public extension UIFont {
    
    /// Halan, Bold, 44px
    class var displayLg: UIFont {
        return UIFont(name: AppFonts.bold(), size: 44)!
    }
    
    /// Halan, Bold, 32px
    class var display: UIFont {
        return UIFont(name: AppFonts.bold(), size: 32)!
    }
    
    /// Halan, Medium, 26px
    class var h1: UIFont {
        return UIFont(name: AppFonts.semiBold(), size: 26)!
    }
    
    /// Halan, Bold, 24px
    class var h2: UIFont {
        return UIFont(name: AppFonts.semiBold(), size: 24)!
    }
    
    /// Halan, Medium, 20px
    class var h3: UIFont {
        return UIFont(name: AppFonts.semiBold(), size: 20)!
    }
    
    /// Halan, Medium, 18px
    class var h4: UIFont {
        return UIFont(name: AppFonts.semiBold(), size: 18)!
    }
    
    /// Halan, Medium, 16px
    class var subTitle1: UIFont {
        return UIFont(name: AppFonts.semiBold(), size: 16)!
    }
    
    /// Halan, Regular, 16px
    class var subTitle2: UIFont {
        return UIFont(name: AppFonts.regular(), size: 16)!
    }
    
    /// Halan, Medium, 14px
    class var subTitle3: UIFont {
        return UIFont(name: AppFonts.semiBold(), size: 14)!
    }
    
    /// Halan, Regular, 16px
    class var p1: UIFont {
        return UIFont(name: AppFonts.semiBold(), size: 16)!
    }
    
    /// Halan, Medium, 16px
    class var p2: UIFont {
        return UIFont(name: AppFonts.regular(), size: 16)!
    }
    
    /// Halan, Regular, 14px
    class var p3: UIFont {
        return UIFont(name: AppFonts.regular(), size: 14)!
    }
    
    /// Halan, Bold, 13px
    class var caption1: UIFont {
        return UIFont(name: AppFonts.bold(), size: 13)!
    }
    
    /// Halan, Regular, 13px
    class var caption2: UIFont {
        return UIFont(name: AppFonts.regular(), size: 13)!
    }
    
    /// Halan, Medium, 13px
    class var caption3: UIFont {
        return UIFont(name: AppFonts.medium(), size: 13)!
    }
    
    /// Halan, Bold, 18px
    class var button1: UIFont {
        return UIFont(name: AppFonts.bold(), size: 18)!
    }
    
    /// Halan, Bold, 14px
    class var button2: UIFont {
        return UIFont(name: AppFonts.bold(), size: 14)!
    }
    
    /// Halan, Medium, 13px
    class var tabBarDefault: UIFont {
        return UIFont(name: AppFonts.medium(), size: 12)!
    }
    
    /// Halan, Bold, 13px
    class var tabBarSelected: UIFont {
        return UIFont(name: AppFonts.bold(), size: 12)!
    }
    
    /// Halan, Medium, 18px
    class var navigationTitle: UIFont {
        return UIFont(name: AppFonts.medium(), size: 18)!
    }
    
    /// Halan, SemiBold, 13px
    class var navTab: UIFont {
        return UIFont(name: AppFonts.semiBold(), size: 13)!
    }
    
    class func customFont(fontName: String, fontSize: CGFloat) -> UIFont {
        return UIFont(name: fontName, size: fontSize)!
    }
}

fileprivate struct AppFonts {
    
    static func regular() -> String {
        return TypeName.Regular.ar.rawValue
    }
    
    static func medium() -> String {
        return TypeName.Medium.ar.rawValue
    }
    
    static func bold() -> String {
        return TypeName.Bold.ar.rawValue
    }
    
    static func semiBold() -> String {
        return TypeName.SemiBold.ar.rawValue
    }
}

fileprivate struct TypeName {
    
    fileprivate enum Regular: String {
        case ar = "Halan-Regular"
    }
    
    fileprivate enum Medium: String {
        case ar = "Halan-Medium"
    }
    
    fileprivate enum Bold: String {
        case ar = "Halan-Bold"
    }
    
    fileprivate enum SemiBold: String {
        case ar = "Halan-SemiBold"
    }
}
