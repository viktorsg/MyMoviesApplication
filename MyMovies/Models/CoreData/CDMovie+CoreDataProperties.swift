//
//  CDMovie+CoreDataProperties.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var id        : Int64
    @NSManaged public var voteCount : Int64
    
    @NSManaged public var averageVote : Double
    @NSManaged public var popularity  : Double
    
    @NSManaged public var title            : String?
    @NSManaged public var originalTitle    : String?
    @NSManaged public var overview         : String?
    @NSManaged public var originalLanguage : String?
    @NSManaged public var releaseDate      : String?
    @NSManaged public var backdropPath     : String?
    @NSManaged public var posterPath       : String?
    
    @NSManaged public var adult: Bool
    @NSManaged public var video: Bool
    
    @NSManaged public var genres: NSSet?

}

// MARK: Generated accessors for genres
extension CDMovie {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: CDGenre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: CDGenre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
