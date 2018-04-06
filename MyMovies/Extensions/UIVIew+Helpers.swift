//
//  UIVIew+Helpers.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 6.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

extension UIView {
    
    
    // MARK: Public Methods
    
    func roundCorners(radius: CGFloat, borderWith: CGFloat? = nil, color: UIColor? = nil) {
        self.clipsToBounds      = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth  = borderWith ?? 0.0
        self.layer.borderColor  = (color ?? UIColor.clear).cgColor
    }
    
    func addLoadingIndicator(withStyle style: UIActivityIndicatorViewStyle) {
        self.removeLoadingIndicator()
        
        DispatchQueue.main.async {
            self.layoutIfNeeded()
            
            let activityView                        = UIActivityIndicatorView(frame: CGRect(x      : 0.0,
                                                                                            y      : 0.0,
                                                                                            width  : self.bounds.size.width,
                                                                                            height : self.bounds.size.height))
            activityView.activityIndicatorViewStyle = style
            activityView.tag                        = MAConstants.activityViewTag
            
            self.addSubview(activityView)
            activityView.startAnimating()
        }
    }
    
    func removeLoadingIndicator() {
        DispatchQueue.main.async {
            self.viewWithTag(MAConstants.activityViewTag)?.removeFromSuperview()
        }
    }
    
    func showAnimated(duration: TimeInterval? = nil) {
        self.changeAlpa(1.0, duration: duration ?? MAAnimationDuration.normal)
    }
    
    func hideAnimated(duration: TimeInterval? = nil) {
        self.changeAlpa(0.0, duration: duration ?? MAAnimationDuration.normal)
    }
    
    private func changeAlpa(_ alpha: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
            self.layoutIfNeeded()
        })
    }
    
}
