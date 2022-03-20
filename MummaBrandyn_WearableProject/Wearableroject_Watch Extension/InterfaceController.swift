//
//  InterfaceController.swift
//  Wearableroject_Watch Extension
//
//  Created by Brandyn Roatch on 3/19/22.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    
    let session  = WCSession.default

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
        session.delegate = self
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    //actions
    @IBAction func connectAction() {
        
        print("Should Connect")
        session.activate()
        
    }
    
    
    //WCSession callbacks
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Watch Activated")
        case .notActivated:
            print("Watch Not Activated")
        case .inactive:
            print("Watch Inactive")
        }
    }
    
    
}
