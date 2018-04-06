//
//  MABaseTabBarController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MABaseTabBarController: UITabBarController {
    
    
    // MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customInit()
        self.setData()
        self.applyTheme()
        self.localize()
    }
    
    
    // MARK: Public Methods
    
    func setBackButtonTitle(_ title: String?) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
    
    
    // MARK: Abstract Methods
    
    func customInit() {
        
    }
    
    func setData() {
        
    }
    
    func applyTheme() {
        
    }
    
    func localize() {
        
    }

}
