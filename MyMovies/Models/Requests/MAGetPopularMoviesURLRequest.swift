//
//  MAGetPopularMoviesURLRequest.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 3.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAGetPopularMoviesURLRequest: MABaseURLRequest {

    
    // MARK: Initializers
    
    init(page: Int) {
        super.init()
        
        self.link = MARequestLinks.popularMovies
        
        self.data[.page] = page
    }
    
    
    // MARK: Abstract Methods
    
    override var successAction: Selector {
        return .didGetPopularMovies
    }
    
    override var failedAction: Selector {
        return .getPopularMoviesFailed
    }
    
    override var onSuccessData: Any? {
        guard let response = self.response else {
            return nil
        }
        
        return MAMoviesResult(response: response)
    }
    
}
