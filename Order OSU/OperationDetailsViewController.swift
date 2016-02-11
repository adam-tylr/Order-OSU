//
//  OperationDetailsViewController.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/5/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit

class OperationDetailsViewController: UIViewController {

    // MARK: Properties
    var details = [OperationDetails]()
    var operation = Int?()
    
    @IBOutlet weak var opLogo: UIImageView!
    @IBOutlet weak var opMsg: UILabel!
    @IBOutlet weak var opHours: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadDetails()
        
        if let operation = operation{
            let selected = details[operation]
            opLogo.image = selected.photo
            opMsg.text = selected.msg
            opHours.text = selected.hours
        }
        
    }
    
    func setOperation(identifier: Int){
        operation = identifier
    }
    
    func loadDetails(){
        let photo1 = UIImage(named: "courtside")!
        let courtsideDetails = OperationDetails(photo: photo1, msg: "Order Online and Pickup at Location\nLocated in The RPAC", hours: "Hours of Operation:\nMonday-Thursday 11am - 9:30pm\nFriday 11am - 7:30pm\nSaturday 11:30am - 7:30pm\nSunday 12:30pm - 9:30pm")!
        
        let photo2 = UIImage(named: "pad")!
        let padDetails = OperationDetails(photo: photo2, msg: "Order Online for Pickup or Delivery\n(Additional 30 minutes needed for delivery)\nExample: If you select a 530pm time slot and\nchoose delivery, your order will arrive at 6PM.\nThe PAD is located inside Lawrence Tower", hours: "PAD Delivers Sunday-Saturday 4pm - 12am")!
        
        let photo3 = UIImage(named: "woodys")!
        let woodysDetails = OperationDetails(photo: photo3, msg: "Order Online and Pickup at Location\nLocated in The Ohio Union", hours: "Hours of Operation M-F 11am - 10pm\nSaturday-Sunday 1pm - 10pm")!
        
        details += [courtsideDetails, padDetails, woodysDetails]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let OrdViewController = segue.destinationViewController as! CatTableViewController
        OrdViewController.operation = operation
        
    }


}
