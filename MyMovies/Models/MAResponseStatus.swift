//
//  MAResponseStatus.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 5.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

struct MAResponseStatus {
    
    
    // MARK: Response Status
    
    static let invalidApiKey = 7
    static let timeout       = 999
    
    
    // MARK: Constants
    
    static let kErrorDomain = "com.mymovies.communication"
    
    
    // MARK: Public Methods
    
    static func errorFromResponse(_ response: NSDictionary) -> NSError {
        let status  = response.safeInt(forKey: .statusCode)
        let message = self.message(fromResponse: response, forStatus: status)
        
        return NSError(domain   : kErrorDomain,
                       code     : status,
                       userInfo : [
                        NSLocalizedDescriptionKey : message ?? MAStrings.Errors.standard
            ]
        )
    }
    
    static var standardError: NSError {
        return NSError(domain   : kErrorDomain,
                       code     : -1,
                       userInfo : [
                        NSLocalizedDescriptionKey : MAStrings.Errors.standard
            ]
        )
    }
    
    
    // MARK: Private Methods
    
    private static func message(fromResponse response: NSDictionary, forStatus status: Int) -> String? {
        if status == MAResponseStatus.invalidApiKey {
            return self.errors[status]
        }
        
        return response[MAConstants.Keys.statusMessage] as? String
    }
    
    private static var errors: [Int : String] {
        return [
            MAResponseStatus.invalidApiKey : MAStrings.Errors.standard
        ]
    }

}
