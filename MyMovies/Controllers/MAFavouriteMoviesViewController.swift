//
//  MAFavouriteMoviesViewController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAFavouriteMoviesViewController: MAMoviesViewController {
    
    
    // MARK: Actions
    
    @objc func didMakeDbOperation() {
        self.loadFavouriteMovies()
    }
    
    
    // MARK: Abstract Methods
    
    override func customInit() {
        super.customInit()
        
        self.loadFavouriteMovies()
        
        NotificationCenter.default.addObserver(self,
                                               selector : #selector(didMakeDbOperation),
                                               name     : MANotifications.DidMakeDbOperation,
                                               object   : nil)
    }
    
    
    // MARK: Private Methods
    
    private func loadFavouriteMovies() {
        self.moviesCollectionView.addLoadingIndicator(withStyle: .whiteLarge)
        
        MADatabaseManager.shared.loadFavouriteMovies { (movies, error) in
            self.moviesCollectionView.removeLoadingIndicator()
            
            if let _ = error {
                UIAlertController.showErrorMessage(self)
                return
            }
            
            self.moviesCollectionView.setFavouriteMovies(movies)
        }
    }

}
