//
//  MAAplicationManager.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAAplicationManager: NSObject {
    
    
    // MARK: Variables
    
    private var _processingRequests = 0
    
    
    // MARK: Singleton
    
    static let shared = MAAplicationManager()
    
    
    // MARK: Public Methods
    
    func networkActivityDidStart() {
        _processingRequests += 1
        self.updateNetworkActivityIndicator()
    }
    
    func networkActivityDidFinish() {
        _processingRequests -= 1
        self.updateNetworkActivityIndicator()
    }
    
    
    // MARK: Private Methods
    
    private func updateNetworkActivityIndicator() {
        if _processingRequests < 0 {
            _processingRequests = 0
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = self._processingRequests > 0
        }
    }
}
