//
//  MAMoviesViewController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAMoviesViewController: MABaseViewController {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var moviesCollectionView: MAMoviesCollectionView!
    
    
    // MARK: Variables
    
    var getMovies = true
    
    private var _selectedMovie: MAMovie?
    
    private var currentPage: Int = 1
    
    
    // MARK: Constants
    
    let kMovieDetailsSegue = "movieDetails"
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kMovieDetailsSegue {
            let controller   = segue.destination as! MAMovieDetailsViewController
            controller.movie = _selectedMovie
        }
    }
    
    
    // MARK: Public Methods
    
    func handleMoviesResult(_ result: MAMoviesResult) {
        self.moviesCollectionView.setMoviesResult(result)
    }
    
    
    // MARK: Abstract Methods
    
    override func customInit() {
        super.customInit()
        
        self.moviesCollectionView.moviesCollectionDelegate = self
    }
    
}

extension MAMoviesViewController: MAMoviesCollectionViewDelegate {
    
    // MARK: Movies Collection View Delegate
    
    @objc func didRequestMovies(forPage page: Int) {
        
    }
    
    func collectionView(_ collectionView: MAMoviesCollectionView, didSelectMovie movie: MAMovie) {
        _selectedMovie = movie
        
        self.performSegue(withIdentifier: kMovieDetailsSegue, sender: self)
    }
    
}
