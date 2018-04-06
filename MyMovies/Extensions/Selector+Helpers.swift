//
//  Selector+Helpers.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import Foundation

extension Selector {
    
    
    // MARK: Requests
    
    static let didGetPopularMovies    = #selector(MACommunicationDelegate.didGetPopularMovies(_:))
    static let getPopularMoviesFailed = #selector(MACommunicationDelegate.getPopularMoviesFailed(withError:))
    
    static let didGetTopRatedMovies    = #selector(MACommunicationDelegate.didGetTopRatedMovies(_:))
    static let getTopRatedMoviesFailed = #selector(MACommunicationDelegate.getTopRatedMoviesFailed(withError:))
    
}
