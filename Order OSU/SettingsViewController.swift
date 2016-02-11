//
//  SettingsViewController.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/5/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var save: UIButton!
    
    @IBAction func SavePressed(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(name.text, forKey: "UserName")
        defaults.setObject(phone.text, forKey: "UserPhone")
        defaults.setObject(email.text, forKey: "UserEmail")
        
        let alert = UIAlertController(title: "Your information has been saved", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = NSUserDefaults.standardUserDefaults()
        var userName = defaults.stringForKey("UserName") as String!
        var userPhone = defaults.stringForKey("UserPhone") as String!
        var userEmail = defaults.stringForKey("UserEmail") as String!
        if (userName == nil){
            userName = ""
        }
        if (userPhone == nil){
            userPhone = ""
        }
        if (userEmail == nil){
            userEmail = ""
        }
        name.text = userName
        phone.text = userPhone
        email.text = userEmail

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
