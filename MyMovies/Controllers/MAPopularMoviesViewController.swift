//
//  MAPopularMoviesViewController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAPopularMoviesViewController: MAMoviesViewController {
    
    
    // MARK: Abstract Methods
    
    override func customInit() {
        super.customInit()
        
        self.moviesCollectionView.addLoadingIndicator(withStyle: .whiteLarge)
        self.getPopularMovies()
    }
    
    override func localize() {
        super.localize()
        
        self.tabBarItem.title = MAStrings.popular
    }
    
    
    // MARK: Private Methods
    
    private func getPopularMovies(page: Int = 1) {
        MACommunicationManager.getPopularMovies(page: page)
    }

}

extension MAPopularMoviesViewController {
    
    // MARK: Movies Collection View Delegate
    
    override func didRequestMovies(forPage page: Int) {
        self.getPopularMovies(page: page)
    }
    
}

extension MAPopularMoviesViewController {
    
    // MARK: Communication Delegate
    
    func didGetPopularMovies(_ moviesResult: MAMoviesResult) {
        self.moviesCollectionView.removeLoadingIndicator()
        self.handleMoviesResult(moviesResult)
    }
    
    func getPopularMoviesFailed(withError error: NSError) {
        self.moviesCollectionView.removeLoadingIndicator()
        self.requestFailed(withError: error)
    }
    
}
