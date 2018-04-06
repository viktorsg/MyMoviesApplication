//
//  Locale+Helpers.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 6.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import Foundation

extension Locale {
    
    
    // MARK: Public Methods
    
    static var preferredLanguage: String {
        return Locale.components(fromIdentifier: self.preferredLanguages.first ?? "")["kCFLocaleLanguageCodeKey"] ?? ""
    }
    
}
