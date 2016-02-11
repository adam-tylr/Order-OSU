//
//  OperationTableViewController.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/5/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit
import SwiftHTTP

class OperationTableViewController: UITableViewController, NSXMLParserDelegate {
    
    // MARK: Properties
    var operations = [Operation]()
    var returning = Bool?()
    var parser = NSXMLParser()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadOperations()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        checkStatus()
        
        // TODO: add offline alert
        //let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        //self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loadOperations(){
        let photo1 = UIImage(named: "courtside")!
        let operation1 = Operation(name: "Courtside", photo: photo1)!
        
        let photo2 = UIImage(named: "pad")!
        let operation2 = Operation(name: "PAD", photo: photo2)!
        
        let photo3 = UIImage(named: "woodys")!
        let operation3 = Operation(name: "Woody's", photo: photo3)!
        
        operations += [operation1, operation2, operation3]
    }
    
    
    var elements = NSMutableDictionary()
    var element = NSString()
    var status = NSMutableString()
    var enabled = NSMutableString()
    
    func httpGet(callback: (NSData, String?) -> Void) {
        let request = NSURLRequest(URL: NSURL(string: "https://s3-us-west-2.amazonaws.com/order.osu/status.xml")!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
                callback(data!, nil)
        }
        task.resume()
    }
    
    func checkStatus(){
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            //self.checkStatus()
            self.httpGet(){
                (data, error) -> Void in
                if error != nil {
                    print(error)
                } else {
                    let xmlParser = NSXMLParser(data: data)
                    self.parse(xmlParser)
                }
            }
        }
    }
    
    func parse(xmlParser: NSXMLParser){
    
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/order.osu/status.xml")
        let xmlParser = NSXMLParser(contentsOfURL: url!)
        xmlParser!.delegate = self
        status = ""
        enabled = ""
        xmlParser!.parse()
        if (status != "ok"){
            let alert = UIAlertController(title: "Yikes!", message: status as String, preferredStyle: UIAlertControllerStyle.Alert)
            if (enabled == "true"){
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            }
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String){
        if element.isEqualToString("status") {
            status.appendString(string)
        }else if element.isEqualToString("enabled"){
            enabled.appendString(string)
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        element = ""
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
