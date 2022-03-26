//
//  DetailInterfaceController.swift
//  Wearableroject_Watch Extension
//
//  Created by Brandyn Roatch on 3/25/22.
//

import WatchKit
import Foundation
import WatchConnectivity


class DetailInterfaceController: WKInterfaceController {
    
    //Outlets
    @IBOutlet weak var playerLabel: WKInterfaceLabel!
    @IBOutlet weak var tvScoreChange: WKInterfaceTextField!
    
    
    //variables
    var mSession: WCSession = WCSession.default
    var scoreChange: String = ""
    var currentPlayer = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if context != nil{
            print("Found Data")
            if let data = context as? [String:Any]{
                print(data["Name"] ?? "Didn't Get Data Correctly")
                
                guard let name = data["Name"] as? String, let session = data["Session"]  as? WCSession
                else{return}
                
                mSession = session
                
                currentPlayer = name
                playerLabel.setText(currentPlayer)
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //actions
    @IBAction func tfGetText(_ value: NSString?) {
        
        if let tfText = value as String? {
            print("Text Field Value: \(tfText)")
            scoreChange = tfText
        }
        
    }
    
    
    @IBAction func addPressed() {
        print("Add Button Pressed")
        sendMessagePlus()
    }
    
    @IBAction func deductButtonPressed() {
        print("Deduct Button Pressed")
        sendMessageMinus()
    }
    
    
    //methods
    private func sendMessagePlus(){
        
        if mSession.isReachable {
            let message: [String:Any] = ["watchChangePlus": true, "NewScore": scoreChange, "Player": currentPlayer]
                    
            mSession.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    private func sendMessageMinus(){
        
        
        if mSession.isReachable {
            let message: [String:Any] = ["watchChangeMinus": true, "NewScore": scoreChange, "Player": currentPlayer]
                    
            mSession.sendMessage(message, replyHandler: nil, errorHandler: nil)

        }
    }
}
