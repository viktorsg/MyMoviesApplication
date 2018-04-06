//
//  MAPopularMoviesViewController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAPopularMoviesViewController: MAMoviesViewController {
    
    
    // MARK: Controller Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.getMovies {
            self.getMovies = false
            self.getPopularMovies()
        }
    }
    
    
    // MARK: Abstract Methods
    
    override func localize() {
        super.localize()
        
        self.tabBarItem.title = MAStrings.popular
    }
    
    
    // MARK: Private Methods
    
    private func getPopularMovies(page: Int = 1) {
        if page == 1 {
            self.moviesCollectionView.addLoadingIndicator(withStyle: .whiteLarge)
        }
        
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
