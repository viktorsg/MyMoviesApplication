//
//  MAMovieDetailsViewController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAMovieDetailsViewController: MABaseViewController {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var releaseDateView: UIView!
    
    @IBOutlet weak var releaseDateLabel         : MALabel!
    @IBOutlet weak var originalTitleHeaderLabel : MALabel!
    @IBOutlet weak var originalTitleLabel       : MALabel!
    @IBOutlet weak var ratingHeaderLabel        : MALabel!
    @IBOutlet weak var ratingLabel              : MALabel!
    @IBOutlet weak var overviewHeaderLabel      : MALabel!
    @IBOutlet weak var overviewLabel            : MALabel!
    
    
    // MARK: Variables
    
    var movie: MAMovie?
    
    
    // MARK: Actions
    
    @objc func addToFavourites(_ sender: Any) {
        guard let movie = self.movie else {
            UIAlertController.showErrorMessage(self)
            return
        }
        
        movie.addToFavourites { (added) in
            self.setRightBarButton(isFavouriteMovie: added)
            UIAlertController.showMessage(String(format: MAStrings.addedToFavourites, movie.title), sender: self)
        }
    }
    
    @objc func removeFromFavourites(_ sender: Any) {
        guard let movie = self.movie else {
            UIAlertController.showErrorMessage(self)
            return
        }
        
        movie.removeFromFavourites { (removed) in
            self.setRightBarButton(isFavouriteMovie: !removed)
            UIAlertController.showMessage(String(format: MAStrings.removedFromFavourites, movie.title), sender: self)
        }
    }
    
    
    // MARK: Abstract Methods
    
    override func setData() {
        super.setData()
        
        guard let movie = self.movie else {
            UIAlertController.showErrorMessage(self, dismissAction: self.goBack)
            return
        }
        
        self.scrollView.showAnimated(duration: MAAnimationDuration.none)
        
        MAAsyncManager.shared.downloadImage(path: movie.posterPath) { (image) in
            self.posterImageView.image = image
        }
        
        self.navigationItem.title    = movie.title
        self.releaseDateLabel.text   = String(format: MAStrings.releaseDate, movie.releaseDate).uppercased()
        self.originalTitleLabel.text = movie.originalTitle
        self.ratingLabel.text        = String(format: "%.2f", movie.averageVote)
        self.overviewLabel.text      = movie.overview
        
        self.checkIsMovieFavourite()
    }
    
    override func applyTheme() {
        super.applyTheme()
        
        self.releaseDateView.roundCorners(radius: 5.0, borderWith: 1.0, color: .borderOrange)
        
        self.releaseDateLabel        .setFontSize(.normal, style: .normal, color: .white)
        self.originalTitleHeaderLabel.setFontSize(.big,    style: .bold,   color: .white)
        self.originalTitleLabel      .setFontSize(.normal, style: .normal, color: .gray)
        self.ratingHeaderLabel       .setFontSize(.big,    style: .bold,   color: .white)
        self.ratingLabel             .setFontSize(.normal, style: .normal, color: .gray)
        self.overviewHeaderLabel     .setFontSize(.big,    style: .bold,   color: .white)
        self.overviewLabel           .setFontSize(.normal, style: .normal, color: .gray)
    }
    
    override func localize() {
        super.localize()
        
        self.originalTitleHeaderLabel.text = MAStrings.originalTitle
        self.ratingHeaderLabel.text        = MAStrings.ratings
        self.overviewHeaderLabel.text      = MAStrings.overview
    }
    
    
    // MARK: Private Methods
    
    private func checkIsMovieFavourite() {
        guard let movie = self.movie else {
            return
        }
        
        movie.isFavourite(completion: { (isFavourite) in
            self.setRightBarButton(isFavouriteMovie: isFavourite)
        })
    }
    
    private func setRightBarButton(isFavouriteMovie favourite: Bool) {
        self.navigationItem.rightBarButtonItem = favourite ? self.removeFromFavourites : self.addToFavourites
    }
    
    
    // MARK: Helpers
    
    private var removeFromFavourites: UIBarButtonItem {
        return UIBarButtonItem(image: #imageLiteral(resourceName: "favourite-remove"), style: .plain, target: self, action: #selector(removeFromFavourites(_:)))
    }
    
    private var addToFavourites: UIBarButtonItem {
        return UIBarButtonItem(image: #imageLiteral(resourceName: "favourite-add"), style: .plain, target: self, action: #selector(addToFavourites(_:)))
    }

}
