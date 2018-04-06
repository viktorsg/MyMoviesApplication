//
//  MAHomeTabBarController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAHomeTabBarController: MABaseTabBarController {
    
    
    // MARK: Abstract Methods
    
    override func localize() {
        super.localize()
        
        self.navigationItem.title = MAStrings.theMovieDb.uppercased()
        
        self.setBackButtonTitle(MAStrings.back)
    }
    
}
