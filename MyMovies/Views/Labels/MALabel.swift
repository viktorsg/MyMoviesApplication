//
//  MALabel.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MALabel: UILabel {
    
    // MARK: Enums
    
    enum Style {
        case normal
        case italic
        case bold
        case medium
    }
    
    enum FontSize: CGFloat {
        case normal = 15.0
        case big    = 18.0
        case large  = 20.0
    }
    
    
    // MARK: Properties
    
    private var weight: UIFont.Weight = .regular
    private var fontSize: CGFloat = FontSize.normal.rawValue
    private var style: Style = .normal
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.customInit()
        self.applyTheme()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.customInit()
        self.applyTheme()
    }
    
    
    // MARK: Public Methods
    
    func setFontSize(_ fontSize: FontSize, style: MALabel.Style = .normal, color: UIColor = .white) {
        self.style     = style
        self.fontSize  = fontSize.rawValue
        self.textColor = color
        
        self.setFont()
    }
    
    func setFontSize(_ fontSize: FontSize, weight: UIFont.Weight = .light, color: UIColor = .white) {
        self.weight    = weight
        self.fontSize  = fontSize.rawValue
        self.textColor = color
        
        self.setFont()
    }
    
    
    // MARK: Private Methods
    
    private func customInit() {
        self.minimumScaleFactor        = 0.5
        self.adjustsFontSizeToFitWidth = true
    }
    
    private func applyTheme() {
        self.setFont()
    }
    
    private func setFont() {
        self.font = self.styledFont
    }
    
    
    // MARK: Helpers
    
    private var styledFont: UIFont {
        switch self.style {
        case .normal:
            switch self.weight {
            case .light:
                return UIFont.systemFont(ofSize: self.fontSize, weight: .light)
                
            case .thin:
                return UIFont.systemFont(ofSize: self.fontSize, weight: .thin)
                
            case .ultraLight:
                return UIFont.systemFont(ofSize: self.fontSize, weight: .ultraLight)
                
            default:
                return UIFont.systemFont(ofSize: self.fontSize)
            }
            
        case .bold:
            return UIFont.boldSystemFont(ofSize: self.fontSize)
            
        case .medium:
            return UIFont.systemFont(ofSize: self.fontSize, weight: .medium)
            
        case .italic:
            return UIFont.italicSystemFont(ofSize: self.fontSize)
        }
    }
}

