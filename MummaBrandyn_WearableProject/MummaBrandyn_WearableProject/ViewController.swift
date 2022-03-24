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
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    
    
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
        
        //set scores to 0 and get initial scores
        setInitalScore()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPlayerScores()
    }
    
    //actions
    @IBAction func resetBtnPressed(_ sender: Any) {
        
        getPlayerScores()
        
    }
    
    
    //methods
    private func updateConnection() {
        
        connectionView.backgroundColor = UIColor.init(named: "ConnectionViewGreen")
        connectionLabel.text = "Device Connected"
        
    }
    
    private func getPlayerScores(){
        
        let alert = UIAlertController(title: "Initial Score", message: "Enter in the initial scores for the players.", preferredStyle: .alert)
        
        alert.addTextField { (tField) in
            tField.placeholder = "Initial Score"
            tField.returnKeyType = .continue
            tField.keyboardType = .numberPad
        }
        
        let confirmAction = UIAlertAction(title: "Set Score", style: .default) { (action) in
            guard let fields = alert.textFields, fields.count == 1
            else {
                return
            }
            
            let scoreField = fields[0]
            
            guard let initialScore = scoreField.text, !initialScore.isEmpty
            else {
                return
            }
            
            print("Initial Score: \(initialScore)")
            let scoreNum: Int = Int(initialScore) ?? 0
            
            self.player1Score = scoreNum
            self.player2Score = scoreNum
            
            self.setInitalScore()
        }
        
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    private func setInitalScore() {
        player1Label.text = "\(player1Score)"
        player2Label.text = "\(player2Score)"
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

