//
//  MABaseViewController.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 3.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MABaseViewController: UIViewController,
                            MACommunicationDelegate {

    
    // MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customInit()
        self.setData()
        self.applyTheme()
        self.localize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MACommunicationManager.shared.addDelegate(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        MACommunicationManager.shared.removeDelegate(self)
        
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: Public Methods
    
    func setBackButtonTitle(_ title: String?) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
    
    func goBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func requestFailed(withError error: NSError) {
        self.requestFailed(withError: error, dismissHandler: nil)
    }
    
    func requestFailed(withError error: NSError, dismissHandler: (() -> Void)?) {
        UIAlertController.showErrorMessage(error.localizedDescription, sender: self, dismissAction: {
            dismissHandler?()
        })
    }
    
    
    // MARK: Abstract Methods
    
    func customInit() {
        
    }
    
    func setData() {
        
    }
    
    func applyTheme() {
        
    }
    
    func localize() {
        
    }
    
}
