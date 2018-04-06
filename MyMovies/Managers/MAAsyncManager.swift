//
//  MAAsyncManager.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAAsyncManager: NSObject {
    
    
    // MARK: Constants
    
    private let kDownloadQueueName = "com.mymovies.download"
    
    
    // MARK: Variables
    
    private var _downloadQueue: DispatchQueue
    
    
    // MARK: Singleton
    
    static let shared = MAAsyncManager()
    
    
    // MARK: Initializers
    
    override init() {
        _downloadQueue = DispatchQueue(label: kDownloadQueueName, qos: .`default`, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        
        super.init()
    }
    
    
    // MARK: Public Methods
    
    func downloadImage(path: String, completion: @escaping ((UIImage?) -> Void)) {
        if path.isEmpty {
            completion(nil)
            return
        }
        
        guard let url = self.fileDownloadURL(path: path) else {
            completion(nil)
            return
        }
        
        if let image = MAFileManager.shared.poster(path) {
            completion(image)
            return
        }
        
        _downloadQueue.async {
            var imageData: Data?
            
            do {
                imageData = try Data(contentsOf: url)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            var image: UIImage?
            
            if let data = imageData {
                image = UIImage(data: data)
                MAFileManager.shared.savePoster(guid: path, imageData: data)
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    
    // MARK: Helpers
    
    private func fileDownloadURL(path: String) -> URL? {
        return URL(string: "\(MAConfig.EndPoints.imageDownload)\(path)")
    }
    
}
