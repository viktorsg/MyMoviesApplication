//
//  MAConstants.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import Foundation

struct MARequestLinks {
    
    static let popularMovies  = "/movie/popular"
    static let topRatedMovies = "/movie/top_rated"
    
}

struct MAConfig {
    
    static let host   = "http://api.themoviedb.org/3"
    static let apiKey = ""
    
    struct EndPoints {
        static let imageDownload = "https://image.tmdb.org/t/p/w185_and_h278_bestv2/"
    }
    
}

struct MAHttpMethod {
    
    static let get = "GET"
    
}

struct MAConstants {
    
    static let activityViewTag = 1000
    
    struct Keys {
        static let success          = "success"
        static let language         = "language"
        static let results          = "results"
        static let id               = "id"
        static let averageVote      = "vote_average"
        static let genreIds         = "genre_ids"
        static let originalTitle    = "original_title"
        static let backdropPath     = "backdrop_path"
        static let adult            = "adult"
        static let popularity       = "popularity"
        static let posterPath       = "poster_path"
        static let title            = "title"
        static let overview         = "overview"
        static let originalLanguage = "original_language"
        static let voteCount        = "vote_count"
        static let releaseDate      = "release_date"
        static let video            = "video"
        static let page             = "page"
        static let totalPages       = "total_pages"
        static let totalResults     = "total_results"
        static let statusCode       = "status_code"
        static let statusMessage    = "status_message"
    }
    
}

struct MAColors {
    
    static let borderOrange = "FFAA4E"
    
}

struct MAAnimationDuration {
    
    static let none   : TimeInterval = 0.0
    static let fast   : TimeInterval = 0.15
    static let normal : TimeInterval = 0.3
    
}

struct MANotifications {
    
    static let DidMakeDbOperation = Notification.Name(rawValue: "databaseOperation")
}
