//
//  MAGetTopRatedMoviesURLRequest.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAGetTopRatedMoviesURLRequest: MABaseURLRequest {

    
    // MARK: Initializers
    
    init(page: Int) {
        super.init()
        
        self.link = MARequestLinks.topRatedMovies
        
        self.data[.page] = page
    }
    
    
    // MARK: Abstract Methods
    
    override var successAction: Selector {
        return .didGetTopRatedMovies
    }
    
    override var failedAction: Selector {
        return .getTopRatedMoviesFailed
    }
    
    override var onSuccessData: Any? {
        guard let response = self.response else {
            return nil
        }
        
        return MAMoviesResult(response: response)
    }
    
}
