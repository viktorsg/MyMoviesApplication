//
//  MAMovie+Helpers.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import Foundation

extension MAMovie {
    
    
    // MARK: Public Methods
    
    static func moviesFromResponse(_ response: NSDictionary) -> [MAMovie] {
        guard let moviesData = response[MAConstants.Keys.results] as? [NSDictionary] else {
            return []
        }
        
        var movies: [MAMovie] = []
        
        for movieData in moviesData {
            movies.append(MAMovie(response: movieData))
            
        }
        
        return movies
    }
    
    static func moviesFromDatabase(_ moviesData: [CDMovie]) -> [MAMovie] {
        var movies: [MAMovie] = []
        
        for movieData in moviesData {
            movies.append(MAMovie(data: movieData))
            
        }
        
        return movies
    }
    
    
    // MARK: Core Data Methods
    
    func isFavourite(completion: @escaping ((Bool) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            MADatabaseManager.shared.checkIsMovieFavourite(self) { (favourite) in
                DispatchQueue.main.async {
                    completion(favourite)
                }
            }
        }
    }
    
    func addToFavourites(completion: @escaping ((Bool) -> Void)) {
        MADatabaseManager.shared.saveFavouriteMovie(self) { (added) in
            DispatchQueue.main.async {
                if added {
                    NotificationCenter.default.post(name: MANotifications.DidMakeDbOperation, object: nil)
                }
                
                completion(added)
            }
        }
    }
    
    func removeFromFavourites(completion: @escaping ((Bool) -> Void)) {
        MADatabaseManager.shared.removeFavouriteMovie(self) { (removed) in
            DispatchQueue.main.async {
                if removed {
                    NotificationCenter.default.post(name: MANotifications.DidMakeDbOperation, object: nil)
                }
                
                completion(removed)
            }
        }
    }
    
}
