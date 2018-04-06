//
//  Dictionary+Helpers.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import Foundation

extension Dictionary {
    
    // MARK: Mutating Methods
    
    mutating func appendDictionary(_ other:Dictionary) {
        for (key, value) in other {
            let _ = autoreleasepool(invoking: {
                self.updateValue(value, forKey:key)
            })
        }
    }
    
}

extension NSDictionary {
    
    
    // MARK: Public Methods
    
    class func baseParametersForRequest(withExtraData extraData: [String : Any]?) -> NSDictionary {
        var data: [String : Any] = [
            .language : Locale.preferredLanguage
        ]
        
        if let specificData = extraData {
            data.appendDictionary(specificData)
        }
        
        return data as NSDictionary
    }
    
    func safeInt(forKey key: String) -> Int {
        return self.object(forKey: key) as? Int ?? -1
    }
    
    func safeInt64(forKey key: String) -> Int64 {
        return self.object(forKey: key) as? Int64 ?? -1
    }
    
    func safeFloat(forKey key: String) -> Float {
        return self.object(forKey: key) as? Float ?? -1.0
    }
    
    func safeDouble(forKey key: String) -> Double {
        return self.object(forKey: key) as? Double ?? -1.0
    }
    
    func safeString(forKey key: String) -> String {
        return self.object(forKey: key) as? String ?? ""
    }
    
    func safeBool(forKey key: String) -> Bool {
        return self.object(forKey: key) as? Bool ?? false
    }
    
    func safeArray(forKey key: String) -> NSArray {
        return self.object(forKey: key) as? NSArray ?? []
    }
    
}
