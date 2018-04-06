//
//  CDGenre+CoreDataProperties.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//
//

import Foundation
import CoreData


extension CDGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGenre> {
        return NSFetchRequest<CDGenre>(entityName: "CDGenre")
    }

    @NSManaged public var movieId: Int64
    @NSManaged public var genreId: Int64

}
