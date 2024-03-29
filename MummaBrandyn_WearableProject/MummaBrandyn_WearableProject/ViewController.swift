//
//  ViewController.swift
//  MummaBrandyn_WearableProject
//
//  Created by Brandyn Roatch on 3/17/22.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate, UITextFieldDelegate {
    
    //outlets
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var tFieldPlayer1: UITextField!
    @IBOutlet weak var tFieldPlayer2: UITextField!
    
    //variables
    let session = WCSession.default
    var player1Score: Int = 0
    var player2Score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set textfield delegates
        self.tFieldPlayer1.delegate = self
        
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
    @IBAction func helpPressed(_ sender: Any) {
        
        //should show the help alert on how to use additional devices
        showHelpAlert()
    }
    
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        
        //runs the same alert from the start of the phone app
        getPlayerScores()
    }
    
    @IBAction func scoreBtnPressed(_ sender: UIButton){
        
        //check the tags of all the plus/minus btns
        switch  sender.tag {
        case 0:
            //should run the minus func for p1
            let newScore = tFieldPlayer1.text
            updatePlayer1ScoreMinus(newScore: newScore!)
        case 1:
            //should run the plus func for p1
            let newScore = tFieldPlayer1.text
            //print("tField is: \(newScore)")
            updatePlayer1ScorePlus(newScore: newScore!)
        case 2:
            //should run the minus for p2
            let newScore = tFieldPlayer2.text
            updatePlayer2ScoreMinus(newScore: newScore!)
        case 3:
            //should run the plus for p2
            let newScore = tFieldPlayer2.text
            updatePlayer2ScorePlus(newScore: newScore!)
        default:
            print("Button not set correctly")
        }
        
    }
    
    
    //methods
    private func updateConnection() {
        
        //should change text to show connection status
        connectionView.backgroundColor = UIColor.init(named: "ConnectionViewGreen")
        connectionLabel.text = "Device Connected"
        
    }
    
    private func setInitalScore() {
        //should set the score of what was set in the alertInitialScore
        player1Label.text = "\(player1Score)"
        player2Label.text = "\(player2Score)"
    }
    
    //score calcs
    
    // *** should be the calcs and checks for changing the scores ***
    
    private func updatePlayer1ScorePlus(newScore: String){
        if let scoreNum = Int(newScore) {
            let scoreTotal = scoreNum + player1Score
            print("Score was Number: \(scoreNum)")
            
            player1Score = scoreTotal
            player1Label.text = "\(player1Score)"
        }
        else{
            print("Score wasn't number")
            showEmptyAlert()
        }
        
        tFieldPlayer1.text = ""
        
    }
    
    private func updatePlayer2ScorePlus(newScore: String){
        if let scoreNum = Int(newScore) {
            let scoreTotal = scoreNum + player2Score
            print("Score was Number: \(scoreNum)")
            
            player2Score = scoreTotal
            player2Label.text = "\(player2Score)"
        }
        else{
            print("Score wasn't number")
            showEmptyAlert()
        }
        
        tFieldPlayer2.text = ""
        
    }
    
    private func updatePlayer1ScoreMinus(newScore: String){
        if let scoreNum = Int(newScore) {
            let scoreTotal = player1Score - scoreNum
            print("Score was Number: \(scoreTotal)")
            
            if scoreTotal <= 0 {
                player1Score = 0
            }
            else{
                player1Score = scoreTotal
            }
            
            player1Label.text = "\(player1Score)"
        }
        else{
            print("Score wasn't number")
            showEmptyAlert()
        }
        
        tFieldPlayer1.text = ""
    }
    
    private func updatePlayer2ScoreMinus(newScore: String){
        if let scoreNum = Int(newScore) {
            let scoreTotal = player2Score - scoreNum
            print("Score was Number: \(scoreTotal)")
            
            if scoreTotal <= 0 {
                player2Score = 0
            }
            else{
                player2Score = scoreTotal
            }
            
            player2Label.text = "\(player2Score)"
        }
        else{
            print("Score wasn't number")
            showEmptyAlert()
        }
        
        tFieldPlayer2.text = ""
    }
    
    //Textfield Callbacks
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        @unknown default:
            print("Some other state not shown")
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
            
            //original suppose to show data transfer, but mostly for changing connection status on phone
            print("Should send Data")
            
            DispatchQueue.main.async {
                self.updateConnection()
            }
        }
        else if (message["watchChangePlus"] as? Bool) != nil {
            
            //should check for data for changing score with one of the plus calcs
            print("Should check for int before changing score")
            DispatchQueue.main.async {
                if let newScore: String = message["NewScore"] as? String {
                    if (message["Player"] as? String) == "PLAYER 1"{
                        print("Should change score for P1 PLUS")
                        
                        //runs p1 plus
                        self.updatePlayer1ScorePlus(newScore: newScore)
                    }
                    else if (message["Player"] as? String) == "PLAYER 2" {
                        print("Should change score for P2 PLUS")
                        
                        //runs p2 plus
                        self.updatePlayer2ScorePlus(newScore: newScore)
                    }
                }
            }
            
        }
        else if (message["watchChangeMinus"] as? Bool) != nil {
            print("Should check for int before changing score")
            
            //should check for data for changing score with one of the minus calcs
            DispatchQueue.main.async {
                if let newScore: String = message["NewScore"] as? String {
                    if (message["Player"] as? String) == "PLAYER 1"{
                        print("Should change score for P1 MINUS")
                        
                        //runs p1 minus
                        self.updatePlayer1ScoreMinus(newScore: newScore)
                    }
                    else if (message["Player"] as? String) == "PLAYER 2" {
                        print("Should change score for P2 MINUS")
                        
                        //runs p2 minus
                        self.updatePlayer2ScoreMinus(newScore: newScore)
                    }
                }
            }
        }
    }
    
    //Alerts
    private func getPlayerScores(){
        
        //*** Use this alert for the reset and for the first alert in app start
        
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
    
    private func showEmptyAlert() {
        
        //*** tells the user to only use numbers, if using a connected keyboard instead of on the phone/sim
        
        let alert = UIAlertController(title: "Problem Changing Score", message: "Either the input was empty or the value wasn't a number.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showHelpAlert() {
        
        // *** Explains how to connect to watch device
        
        let alert = UIAlertController(title: "How to Connect Device", message: "Download the app for Apple Watch, and make sure both devices are paired before hitting connect on the Watch app.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

