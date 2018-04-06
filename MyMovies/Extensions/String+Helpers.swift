//
//  String+Helpers.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import Foundation

extension String {
    
    
    // MARK: Public Methods
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
