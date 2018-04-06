//
//  MAFileManager.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 4.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MAFileManager: NSObject {
    
    
    // MARK: Variables
    
    private var _fileAccessQueue: DispatchQueue
    
    
    // MARK: Constants
    
    private let kPostersDirectory = "posters"
    private let kFileAccessQueue  = "com.mymovies-fileaccess"
    
    
    // MARK: Singleton
    
    static let shared = MAFileManager()
    
    
    // MARK: Initializers
    
    override init() {
        _fileAccessQueue = DispatchQueue(label: kFileAccessQueue, qos: .`default`, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        
        super.init()
    }
    
    
    // MARK: Public Methods
    
    func poster(_ logoGUID: String) -> UIImage? {
        var poster: UIImage?
        let semaphore = DispatchSemaphore(value: 0)
        
        _fileAccessQueue.sync {
            if let imageData = self.fileNamed("\(kPostersDirectory)/\(logoGUID)") {
                poster = UIImage(data: imageData)
            }
            
            semaphore.signal()
        }
        
        let _ = semaphore.wait(timeout: .distantFuture)
        return poster
    }
    
    func savePoster(guid: String, imageData: Data) {
        _fileAccessQueue.sync {
            self.createDirectory(self.postersDirectory)
            self.saveFile(fileData: imageData, atPath: self.postersPath(posterGuid: guid))
        }
    }
    
    
    // MARK: Private Methods
    
    private func createDirectory(_ directoryName: String) {
        if FileManager.default.fileExists(atPath: directoryName, isDirectory: nil) {
            return
        }
        
        do {
            try FileManager.default.createDirectory(atPath: directoryName, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func fileNamed(_ fileName: String) -> Data? {
        let url  = NSURL(fileURLWithPath: self.documentsPath)
        
        guard let fileURL = url.appendingPathComponent(fileName) else {
            return nil
        }
        
        return FileManager.default.contents(atPath: fileURL.path)
    }
    
    private func saveFile(fileData: Data, atPath: String) {
        do {
            try fileData.write(to: URL(fileURLWithPath: atPath))
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: Helpers
    
    private var documentsPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    }
    
    private var postersDirectory: String {
        return "\(self.documentsPath)/\(kPostersDirectory)"
    }
    
    private func postersPath(posterGuid: String) -> String {
        return "\(self.postersDirectory)/\(posterGuid)"
    }
}
