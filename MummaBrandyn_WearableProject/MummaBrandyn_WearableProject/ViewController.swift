//
//  ViewController.swift
//  MummaBrandyn_WearableProject
//
//  Created by Brandyn Roatch on 3/17/22.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    //outlets
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var connectionLabel: UILabel!
    
    
    //variables
    let session = WCSession.default
    var player1Score: Int = 0
    var player2Score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //watch connectivity
        if WCSession.isSupported() {
            
            session.delegate = self
            session.activate()
        }
        
        
    }
    
    //methods
    private func updateConnection() {
        
        connectionView.backgroundColor = UIColor.init(named: "ConnectionViewGreen")
        connectionLabel.text = "Device Connected"
        
    }
    
    private func getPlayerScores(){
        
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
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if (message["getData"] as? Bool) != nil {
            print("Should send Data")
            
            DispatchQueue.main.async {
                self.updateConnection()
            }
            
            
        }
    }
    
    
}

