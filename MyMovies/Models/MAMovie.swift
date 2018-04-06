//
//  MAdata.swift
//  Mydatas
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAMovie: MABaseModel {
    
    
    // MARK: Properties
    
    private(set) var id        : Int64
    private(set) var voteCount : Int64
    private(set) var genreIds  : [Int64]
    
    private(set) var averageVote : Double
    private(set) var popularity  : Double
    
    private(set) var title            : String
    private(set) var originalTitle    : String
    private(set) var overview         : String
    private(set) var originalLanguage : String
    private(set) var releaseDate      : String
    private(set) var backdropPath     : String
    private(set) var posterPath       : String
    
    private(set) var adult: Bool
    private(set) var video: Bool
    
    
    // MARK: Initializers
    
    override init(response: NSDictionary) {
        self.id        =  response.safeInt64(forKey: .id)
        self.voteCount =  response.safeInt64(forKey: .voteCount)
        self.genreIds  = (response.safeArray(forKey: .genreIds) as? [Int64]) ?? []
        
        self.averageVote = response.safeDouble(forKey: .averageVote)
        self.popularity  = response.safeDouble(forKey: .popularity)
        
        self.title            = response.safeString(forKey: .title)
        self.originalTitle    = response.safeString(forKey: .originalTitle)
        self.overview         = response.safeString(forKey: .overview)
        self.originalLanguage = response.safeString(forKey: .originalLanguage)
        self.releaseDate      = response.safeString(forKey: .releaseData)
        self.backdropPath     = response.safeString(forKey: .backdropPath)
        self.posterPath       = response.safeString(forKey: .posterPath)
        
        self.adult = response.safeBool(forKey: .adult)
        self.video = response.safeBool(forKey: .video)
        
        super.init(response: response)
    }
    
    init(data: CDMovie) {
        self.id        = data.id
        self.voteCount = data.voteCount
        
        self.averageVote = data.averageVote
        self.popularity  = data.popularity
        
        self.title            = data.title            ?? ""
        self.originalTitle    = data.originalTitle    ?? ""
        self.overview         = data.overview         ?? ""
        self.originalLanguage = data.originalLanguage ?? ""
        self.releaseDate      = data.releaseDate      ?? ""
        self.backdropPath     = data.backdropPath     ?? ""
        self.posterPath       = data.posterPath       ?? ""
        
        self.adult = data.adult
        self.video = data.video
        
        var genres: [Int64] = []
        
        for genreId in data.genres ?? [] {
            if let id = genreId as? Int64 {
                genres.append(id)
            }
        }
        
        self.genreIds = genres
        
        super.init()
    }

}
