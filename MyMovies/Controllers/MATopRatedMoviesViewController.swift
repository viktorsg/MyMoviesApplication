//
//  MATopRatedMoviesViewController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MATopRatedMoviesViewController: MAMoviesViewController {

    
    // MARK: Abstract Methods
    
    override func customInit() {
        super.customInit()
        
        self.moviesCollectionView.addLoadingIndicator(withStyle: .whiteLarge)
        self.getTopRatedMovies()
    }
    
    override func localize() {
        super.localize()
        
        self.tabBarItem.title = MAStrings.topRated
    }
    
    
    // MARK: Private Methods
    
    private func getTopRatedMovies(page: Int = 1) {
        MACommunicationManager.getTopRatedMovies(page: page)
    }

}

extension MATopRatedMoviesViewController {
    
    // MARK: Movies Collection View Delegate
    
    override func didRequestMovies(forPage page: Int) {
        self.getTopRatedMovies(page: page)
    }
    
}

extension MATopRatedMoviesViewController {
    
    // MARK: Communication Delegate
    
    func didGetTopRatedMovies(_ moviesResult: MAMoviesResult) {
        self.moviesCollectionView.removeLoadingIndicator()
        self.handleMoviesResult(moviesResult)
    }
    
    func getTopRatedMoviesFailed(withError error: NSError) {
        self.moviesCollectionView.removeLoadingIndicator()
        self.requestFailed(withError: error)
    }
    
}
