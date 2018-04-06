//
//  MAMovieCollectionViewCell.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAMovieCollectionViewCell: MAImageCollectionViewCell {
    
    
    // MARK: Variables
    
    var movie: MAMovie? {
        didSet {
            self.setData()
        }
    }
    
    
    // MARK: Private Methods
    
    private func setData() {
        self.addLoadingIndicator(withStyle: .white)
        self.imageView.image = nil
        
        MAAsyncManager.shared.downloadImage(path: self.movie?.posterPath ?? "") { (image) in
            self.removeLoadingIndicator()
            self.imageView.image = image
        }
    }
    
}
