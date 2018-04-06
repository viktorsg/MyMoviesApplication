//
//  MACommunicationDelegate.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 3.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import Foundation

@objc protocol MACommunicationDelegate {
    
    
    // MARK: Requests
    
    @objc optional func didGetPopularMovies(_ moviesResult: MAMoviesResult)
    @objc optional func getPopularMoviesFailed(withError error: NSError)
    
    @objc optional func didGetTopRatedMovies(_ moviesResult: MAMoviesResult)
    @objc optional func getTopRatedMoviesFailed(withError error: NSError)
    
    
    // MARK: Defaults
    
    @objc optional func defaultSuccess()
    @objc optional func defaultFailure()
    
}
