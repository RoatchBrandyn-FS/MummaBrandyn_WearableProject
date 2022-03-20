//
//  ViewController.swift
//  MummaBrandyn_WearableProject
//
//  Created by Brandyn Roatch on 3/17/22.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    

    //variables
    let session = WCSession.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //watch connectivity
        if WCSession.isSupported() {
            
            session.delegate = self
            session.activate()
        }
        
        
    }

    //WCSession callbacks
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Phone Activated")
        case .notActivated:
            print("Phone Not Activated")
        case .inactive:
            print("Phone Inactive")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session went inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session went deactivated")
    }
    
    
}

