//
//  MACommunicationManager.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 3.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import Foundation

class MACommunicationManager: NSObject {
    
    
    // MARK: Variables
    
    private var _communicationQueue : DispatchQueue
    private var _delegates          : NSHashTable<MACommunicationDelegate>
    private var _requests           : [MABaseURLRequest]
    
    
    // MARK: Constants
    
    private let kCommunicationQueue = "com.movies.application.communication"
    
    
    // MARK: Singleton
    
    static let shared = MACommunicationManager()
    
    
    // MARK: Initializers
    
    override init() {
        _communicationQueue = DispatchQueue(label: kCommunicationQueue, qos: .`default`, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        _delegates          = NSHashTable<MACommunicationDelegate>.weakObjects()
        _requests           = []
        
        super.init()
    }
    
    
    // MARK: Public Methods
    
    func addDelegate<T: AnyObject>(_ delegate: T) where T: MACommunicationDelegate {
        self.operateWithDelegatesSafely {
            if !_delegates.contains(delegate) {
                _delegates.add(delegate)
            }
        }
    }
    
    func removeDelegate<T: AnyObject>(_ delegate: T) where T: MACommunicationDelegate {
        self.operateWithDelegatesSafely {
            if _delegates.contains(delegate) {
                _delegates.remove(delegate)
            }
        }
    }
    
    func didReceiveResponseForRequest(_ request: MABaseURLRequest) {
        self.handleRequestResponse(request)
        
        guard let indexOfRequestToDelete = _requests.index(of: request) else {
            return
        }
        
        if !_requests.isEmpty && indexOfRequestToDelete < _requests.count  {
            _requests.remove(at: indexOfRequestToDelete)
        }
    }
    
    
    // MARK: Requests
    
    static func getPopularMovies(page: Int) {
        self.sendRequest(MAGetPopularMoviesURLRequest(page: page))
    }
    
    static func getTopRatedMovies(page: Int) {
        self.sendRequest(MAGetTopRatedMoviesURLRequest(page: page))
    }
    
    
    // MARK: Private Methods
    
    private class func sendRequest(_ request: MABaseURLRequest) {
        MACommunicationManager.shared.sendRequest(request)
    }
    
    private func sendRequest(_ request: MABaseURLRequest) {
        _requests.append(request)
        
        _communicationQueue.async {
            request.send()
        }
    }
    
    private func handleRequestResponse(_ request: MABaseURLRequest) {
        guard let response = request.response else {
            self.notifyDelegates(selector: request.failedAction, object: MAResponseStatus.standardError)
            return
        }
        
        if self.responseIsOk(response, forRequest: request) {
            self.notifyDelegates(selector: request.successAction, object: request.onSuccessData)
            return
        }
        
        self.notifyDelegates(selector: request.failedAction, object: MAResponseStatus.errorFromResponse(response))
    }
    
    func notifyDelegates(selector: Selector, object: Any?) {
        MAAplicationManager.shared.networkActivityDidFinish()
        
        self.operateWithDelegatesSafely {
            for delegate in self.delegates {
                if !delegate.responds(to: selector) {
                    continue
                }
    
                delegate.performSelector(onMainThread: selector, with: object, waitUntilDone: false)
            }
        }
    }
    
    private func responseIsOk(_ response: NSDictionary, forRequest request: MABaseURLRequest) -> Bool {
        if let success = response[MAConstants.Keys.success] as? Bool {
            return success
        }
        
        if let code = request.httpCode, code != 200 {
            return false
        }
        
        return true
    }
    
    private func operateWithDelegatesSafely(block: () -> ()) {
        objc_sync_enter(_delegates)
        block()
        objc_sync_exit(_delegates)
    }
    
    
    // MARK: Helpers
    
    private var delegates: [AnyObject] {
        return _delegates.allObjects
    }
    
}
