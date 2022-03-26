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
    var mScore: Int = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if context != nil{
            print("Found Data")
            if let data = context as? [String:Any]{
                print(data["Name"] ?? "Didn't Get Data Correctly")
                
                guard let name = data["Name"] as? String
                else{return}
                
                playerLabel.setText(name)
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
    
    
    //methods
    
    

}
