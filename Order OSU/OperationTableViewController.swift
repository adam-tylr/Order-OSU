//
//  OperationTableViewController.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/5/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit
import SwiftHTTP
import SWXMLHash

class OperationTableViewController: UITableViewController, NSXMLParserDelegate {
    
    // MARK: Properties
    var operations = [Operation]()
    var returning = Bool?()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadOperations()

        // First Run Notificaion
        // Load the order
        let defaults = NSUserDefaults.standardUserDefaults()
        if (!defaults.boolForKey("notFirstRun")){
            defaults.setValue(true, forKey: "notFirstRun")
            let alert = UIAlertController(title: "Welcome", message: "Select a location to begin your first order or optionally click the settings icon to enter your contact information. This will make the checkout process faster.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Got It!", style: UIAlertActionStyle.Default, handler: nil))
            navigationController?.popViewControllerAnimated(true)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // TODO: add offline alert
        //let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        //self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loadOperations(){
        let photo1 = UIImage(named: "courtsideLogo")!
        let operation1 = Operation(name: "Courtside", photo: photo1)!
        
        let photo2 = UIImage(named: "padLogo")!
        let operation2 = Operation(name: "PAD", photo: photo2)!
        
        let photo3 = UIImage(named: "woodysLogo")!
        let operation3 = Operation(name: "Woody's", photo: photo3)!
        
        operations += [operation1, operation2, operation3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return operations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "OperationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OperationTableViewCell
        
        // Fetches the appropriate operation for the data source layout.
        let operation = operations[indexPath.row]

        // Configure the cell...
        cell.photoImageView.image = operation.photo

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
    {
        //let sourceViewController = sender.sourceViewController
        
        // Pull any data from the view controller which initiated the unwind segue.
        //if let wbViewController = sender.sourceViewController as? WebOrderViewController {
        //}
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetail"{
        
            let OpViewController = segue.destinationViewController as! OperationDetailsViewController
        
            // Get the cell that generated this segue.
            if let selectedOperationCell = sender as? OperationTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedOperationCell)!
                let selectedOperation = indexPath.row
                OpViewController.operation = selectedOperation
            }
        }
        
    }
    

}
