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
    
    //outlets
    @IBOutlet weak var p1Btn: WKInterfaceButton!
    @IBOutlet weak var p2Btn: WKInterfaceButton!
    @IBOutlet weak var connectBtn: WKInterfaceButton!
    
    
    
    //Variables
    let session  = WCSession.default
    var player1Score: Int = 0
    var player2Score: Int = 0

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        disablePlayerBtns()
        
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
        
        let message: [String: Any] = ["getData": true]
        
        if session.isReachable{
            print("Phone Reachable")
            
            enablePlayerBtns()
            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
        else{
            disablePlayerBtns()
        }
    }
    
    //methods
    private func disablePlayerBtns() {
        self.p1Btn.setEnabled(false)
        self.p2Btn.setEnabled(false)
        
        self.connectBtn.setEnabled(true)
    }
    
    private func enablePlayerBtns() {
        //enable players if connected to phone
        self.p1Btn.setEnabled(true)
        self.p2Btn.setEnabled(true)
        
        //turn off connect button
        self.connectBtn.setEnabled(false)
        
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
    
    //segue callbacks
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        
        var playerData: [String:Any] = [String: Any]()
        
        if segueIdentifier == "p1ToDetail"{
            playerData = ["Name": "PLAYER 1", "Session": session]
        }
        else if segueIdentifier == "p2ToDetail"{
            playerData = ["Name": "PLAYER 2", "Session": session]
        }
        
        return playerData
    }
    
}
