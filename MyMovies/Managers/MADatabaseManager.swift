//
//  MADatabaseManager.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit
import CoreData

class MADatabaseManager: NSObject {
    
    
    // MARK: Typealias
    
    typealias MACompletionHandlerBlock = (Bool)              -> Void
    typealias MAErrorHandlerBock       = (Error?)            -> Void
    typealias MAMoviesCompletionBlock  = ([MAMovie], Error?) -> Void
    
    
    // MARK: Variables
    
    private var _databaseQueue: DispatchQueue
    
    
    // MARK: Constants
    
    private let kDatabaseAccessQueue = "com.mymovies-databaseaccess"
    private let kDatabaseName        = "FavouriteMovies"
    private let kMovieEntity         = "CDMovie"
    private let kGenreEntity         = "CDGenre"
    
    
    // MARK: Singleton
    
    static let shared = MADatabaseManager()
    
    
    // MARK: Initializers
    
    override init() {
        _databaseQueue = DispatchQueue(label: kDatabaseAccessQueue, qos: .`default`, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        
        super.init()
    }
    
    
    // MARK: Public Methods
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: kDatabaseName)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.userInfo)
            }
        })
        
        return container
    }()
    
    func checkIsMovieFavourite(_ movie: MAMovie, completion: @escaping MACompletionHandlerBlock) {
        let managedContext = self.persistentContainer.viewContext
        
        let moviesRequest = NSFetchRequest<CDMovie>(entityName: kMovieEntity)
        
        moviesRequest.predicate = NSPredicate(format: "id == %lu", movie.id)
        
        _databaseQueue.async {
            do {
                let count = try managedContext.count(for: moviesRequest)
                completion(count == 1)
            } catch {
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
    
    func loadFavouriteMovies(completion: @escaping MAMoviesCompletionBlock) {
        let managedContext = self.persistentContainer.viewContext
        
        let moviesRequest = NSFetchRequest<CDMovie>(entityName: kMovieEntity)
        
        _databaseQueue.async {
            do {
                let movies = try managedContext.fetch(moviesRequest)
                completion(MAMovie.moviesFromDatabase(movies), nil)
            } catch {
                completion([], nil)
                print(error.localizedDescription)
            }
        }
    }
    
    func saveFavouriteMovie(_ movie: MAMovie, completion: @escaping MACompletionHandlerBlock) {
        let managedContext = self.persistentContainer.viewContext
        
        guard let movieEntity = NSEntityDescription.insertNewObject(forEntityName: kMovieEntity, into: managedContext) as? CDMovie else {
            completion(false)
            return
        }
        
        movieEntity.id        = movie.id
        movieEntity.voteCount = movie.voteCount
        
        movieEntity.averageVote = movie.averageVote
        movieEntity.popularity  = movie.popularity
        
        movieEntity.title            = movie.title
        movieEntity.originalTitle    = movie.originalTitle
        movieEntity.overview         = movie.overview
        movieEntity.originalLanguage = movie.originalLanguage
        movieEntity.releaseDate      = movie.releaseDate
        movieEntity.backdropPath     = movie.backdropPath
        movieEntity.posterPath       = movie.posterPath
        
        movieEntity.adult = movie.adult
        movieEntity.video = movie.video
        
        for genreId in movie.genreIds {
            if let genreEntity = NSEntityDescription.insertNewObject(forEntityName: kGenreEntity, into: managedContext) as? CDGenre {
                genreEntity.movieId = movie.id
                genreEntity.genreId = genreId
                
                movieEntity.addToGenres(genreEntity)
            }
        }
        
        self.saveContext { (error) in
            if let _ = error {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    func removeFavouriteMovie(_ movie: MAMovie, completion: @escaping MACompletionHandlerBlock) {
        let managedContext = self.persistentContainer.viewContext
        
        let movieRequest = NSFetchRequest<CDMovie>(entityName: kMovieEntity)
        
        movieRequest.predicate = NSPredicate(format: "id == %lu", movie.id)
        
        do {
            if let movie = try managedContext.fetch(movieRequest).first {
                managedContext.delete(movie)
                
                self.saveContext()
                completion(true)
                return
            }
        } catch {
            completion(false)
            print(error.localizedDescription)
        }
    }
    
    func saveContext(completion: MAErrorHandlerBock? = nil) {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            _databaseQueue.async {
                do {
                    try context.save()
                    completion?(nil)
                } catch {
                    completion?(error as NSError)
                }
            }
        }
    }

}
