//
//  MAMoviesCollectionView.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAMoviesCollectionView: UICollectionView {
    
    
    // MARK: Variables
    
    open var moviesCollectionDelegate: MAMoviesCollectionViewDelegate?
    
    
    private var _moviesResult : MAMoviesResult?
    private var _movies       : [MAMovie] = []
    
    
    // MARK: Constants
    
    private let kInset: CGFloat = 20.0
    
    private let kMovieCellIdentifier = "movieCell"
    
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.customInit()
        self.registerNibs()
    }
    
    
    // MARK: Public Methods
    
    func setMoviesResult(_ result: MAMoviesResult) {
        _moviesResult = result
        
        _movies.append(contentsOf: result.movies)
        self.reload()
    }
    
    func setFavouriteMovies(_ movies: [MAMovie]) {
        _movies = movies
        self.reload()
    }
    
    
    // MARK: Private Methods
    
    private func customInit() {
        self.dataSource = self
        self.delegate   = self
    }
    
    private func registerNibs() {
        self.register(UINib(nibName: self.cellNibName, bundle: nil), forCellWithReuseIdentifier: kMovieCellIdentifier)
    }
    
    private func reload() {
        UIView.transition(with: self, duration: 0.25, options: .curveLinear, animations: {
            DispatchQueue.main.async {
                super.reloadData()
            }
        }, completion: nil)
    }
    
    
    // MARK: Helpers
    
    private var hasMorePages: Bool {
        guard let result = _moviesResult else {
            return false
        }
        
        return result.page < result.totalPages
    }
    
    private var cellNibName: String {
        return String(describing: MAMovieCollectionViewCell.classForCoder())
    }

}

extension MAMoviesCollectionView: UICollectionViewDataSource {
    
    // MARK: Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMovieCellIdentifier, for: indexPath)
        
        if let imageCell = cell as? MAMovieCollectionViewCell {
            imageCell.movie = _movies[indexPath.item]
        }
        
        return cell
    }
    
}

extension MAMoviesCollectionView: UICollectionViewDelegateFlowLayout {
    
    // MARK: Collection View Layout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.bounds.width - 3 * kInset) / 2
        
        return CGSize(width: width, height: width * 1.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: kInset, left: kInset, bottom: kInset, right: kInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kInset
    }
    
}

extension MAMoviesCollectionView: UICollectionViewDelegate {
    
    // MARK: Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.hasMorePages, indexPath.item == _movies.count - 1, let currentPage = _moviesResult?.page {
            self.moviesCollectionDelegate?.didRequestMovies(forPage: Int(currentPage + 1))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moviesCollectionDelegate?.collectionView(self, didSelectMovie: _movies[indexPath.row])
    }
    
}

protocol MAMoviesCollectionViewDelegate {
    
    func didRequestMovies(forPage page: Int)
    func collectionView(_ collectionView: MAMoviesCollectionView, didSelectMovie movie: MAMovie)
}
