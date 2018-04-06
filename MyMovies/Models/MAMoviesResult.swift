//
//  MAMoviesResult.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAMoviesResult: MABaseModel {
    
    
    // MARK: Properties
    
    private(set) var totalPages: Int64
    private(set) var totalResults: Int64
    private(set) var page: Int64
    
    private(set) var movies: [MAMovie]
    
    
    // MARK: Initializers
    
    override init(response: NSDictionary) {
        self.totalPages   = response.safeInt64(forKey: .totalPages)
        self.totalResults = response.safeInt64(forKey: .totalResults)
        self.page         = response.safeInt64(forKey: .page)
        
        self.movies = MAMovie.moviesFromResponse(response)
        
        super.init(response: response)
    }

}
