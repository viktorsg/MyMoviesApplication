//
//  UIAlertController+Helpers.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 6.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    
    typealias MAHandlerBlock = () -> Void
    
    
    // MARK: Public Methods
    
    class func showErrorMessage(_ sender: UIViewController) {
        self.showMessage(MAStrings.Errors.standard, sender: sender)
    }
    
    class func showErrorMessage(_ sender: UIViewController, dismissAction: MAHandlerBlock?) {
        self.showErrorMessage(MAStrings.Errors.standard, sender: sender, dismissAction: dismissAction)
    }
    
    class func showMessage(_ message: String, sender: UIViewController) {
        self.showErrorMessage(message, sender: sender, dismissAction: nil)
    }
    
    class func showErrorMessage(_ message: String, sender: UIViewController, dismissAction: MAHandlerBlock?) {
        let okAction = self.okAction(sender, handler: dismissAction)
        
        self.showAlert(MAStrings.theMovieDb, message: message, actions: [okAction], sender: sender)
    }
    
    
    // MARK: Private Methods
    
    private class func okAction(_ sender: UIViewController, handler: MAHandlerBlock?) -> UIAlertAction {
        return self.cancelAction(MAStrings.ok, sender: sender, handler: handler)
    }
    
    private class func cancelAction(_ title: String? = nil, sender: UIViewController, handler: MAHandlerBlock?) -> UIAlertAction {
        return self.alertAction(title ?? MAStrings.cancel, style: .cancel, sender: sender, handler: handler)
    }
    
    private class func alertAction(_ title: String, sender: UIViewController, handler: MAHandlerBlock?) -> UIAlertAction {
        return self.alertAction(title, style: .`default`, sender: sender, handler: handler)
    }
    
    private class func alertAction(_ title: String, style: UIAlertActionStyle, sender: UIViewController, handler: MAHandlerBlock?) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style) { (alertAction) in
            handler?()
        }
        
        return action
    }
    
    private class func showAlert(_ title: String?, message: String?, actions: [UIAlertAction], sender: UIViewController) {
        self.show(title, message: message, style: .alert, actions: actions, sender: sender)
    }
    
    private class func show(_ title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction], sender: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        sender.present(alertController, animated: true, completion: nil)
    }
    
}
