//
//  ViewController.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 krashless.com. All rights reserved.
//

import UIKit

final class ViewController: BaseViewController {
    
    //MARK:- variables
    
    private var locationObj : LocationsModel = LocationsModel()

    //MARK- life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestLocations()
        
        
    }
    
    //MARK:- Helping Methods
    
    
    
    //MARK:- API calls
    
    func requestLocations() {
        
        showLoadingIndicator()
        // assign delegate to perform did Success or Fail methods  at BaseViewConrtoller
        // overid them if you want specific actions
        // adding delegate to perform general actions after api call back
        // EX: hide Loading indicator , or show general error .
        
        locationObj = LocationsModel(delegate: self)
        
        locationObj.requestTopUsers(WithCallBack: { [weak self](model) in
            if let obj = model as? LocationsModel {
                self?.locationObj.placemarks = obj.placemarks
                if let rootVC = UIViewController.viewController(withStoryBoardname: RootSB.name) as? RootVC{
                    rootVC.locationObj = self?.locationObj ?? LocationsModel()
                    appDelegate?.window?.rootViewController = rootVC
                }
                
            }
        }) { (_) in
            
            // Already we handled error in base
            // here if you want make some actions in error OR override DidFail method In BaseViewController
            
        }
        
        
    }
    
}
