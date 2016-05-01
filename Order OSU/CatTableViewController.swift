//
//  CatTableViewController.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/6/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit

class CatTableViewController: UITableViewController {
    var categories = [[FoodCategory]()]
    var operation = Int?()
    var catItems = [FoodCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadDetails()
        
        if let operation = operation{
            catItems = categories[operation]
        }
    }
    
    func loadDetails(){
        
        categories = []
        
        // Placeholder image
        //let photo0 = UIImage(named: "blankCat")!
        
        // Courtside
        let photo1 = UIImage(named: "courtCat1")!
        let cat1 = FoodCategory(name: "Courtside Classic Meals", photo: photo1, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT95_SUBCAT610&store=845&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!
        
        
        let photo2 = UIImage(named: "courtCat2")!
        let cat2 = FoodCategory(name: "Grain and Vegetable Meals", photo: photo2, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT95_SUBCAT612&store=845&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!
        
        let photo3 = UIImage(named: "courtCat3")!
        let cat3 = FoodCategory(name: "Salad and Wrap Meals", photo: photo3, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT95_SUBCAT611&store=845&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!
        
        let photo4 = UIImage(named: "courtCat4")!
        let cat4 = FoodCategory(name: "Courtside Pasta Meals", photo: photo4, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT95_SUBCAT613&store=845&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!
        
        categories.append([cat1, cat2, cat3, cat4])
        
        // PAD
        let photo5 = UIImage(named: "padCat1")!
        let cat5 = FoodCategory(name: "Pizza Meals", photo: photo5, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT4_SUBCAT616&store=828&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!
        
        let photo6 = UIImage(named: "padCat2")!
        let cat6 = FoodCategory(name: "Boneless Wing Meals", photo: photo6, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT4_SUBCAT617&store=828&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!

        let photo7 = UIImage(named: "padCat3")!
        let cat7 = FoodCategory(name: "Sub Sandwich Meals", photo: photo7, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT4_SUBCAT618&store=828&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!

        let photo8 = UIImage(named: "padCat4")!
        let cat8 = FoodCategory(name: "Appetizer Meals", photo: photo8, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT4_SUBCAT620&store=828&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!

        let photo9 = UIImage(named: "padCat5")!
        let cat9 = FoodCategory(name: "Salad Meals", photo: photo9, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT4_SUBCAT619&store=828&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!
        
        categories.append([cat5, cat6, cat7, cat8, cat9])
        
        // Woody's
        let photo10 = UIImage(named: "woodyCat1")!
        let cat10 = FoodCategory(name: "Full Sheet Pizza", photo: photo10, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT97_SUBCAT606&store=846&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!

        let photo11 = UIImage(named: "woodyCat2")!
        let cat11 = FoodCategory(name: "Half Sheet Pizza", photo: photo11, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT97_SUBCAT605&store=846&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!

        let photo12 = UIImage(named: "woodyCat3")!
        let cat12 = FoodCategory(name: "Pizza Without Gluten Ingredients", photo: photo12, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT97_SUBCAT609&store=846&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!

        let photo13 = UIImage(named: "woodyCat4")!
        let cat13 = FoodCategory(name: "Sliced Pizza, Sub, and Calzone Meals", photo: photo13, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT97_SUBCAT615&store=846&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!
        
        let photo14 = UIImage(named: "woodyCat5")!
        let cat14 = FoodCategory(name: "Bone-In Wing Meals", photo: photo14, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT97_SUBCAT607&store=846&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!
        
        let photo15 = UIImage(named: "woodyCat6")!
        let cat15 = FoodCategory(name: "Boneless Wing Meals", photo: photo15, link: "http://epos10-phx.sequoiars.com/ePOS?this_category=ROOT97_SUBCAT608&store=846&form=shared3%2fgm%2fmain%2ehtml&design=mobile&set_count_cookie=YES&listtype=begin&item_qty=10")!

        
        categories.append([cat10, cat11, cat12, cat13, cat14, cat15])
        
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
        
        return catItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("foodCatCell", forIndexPath: indexPath) as! CatTableViewCell

        // Fetches appropriate category
        let cat = catItems[indexPath.row]
        
        // Configure Cell
        cell.catName.text = cat.name
        cell.catPhoto.image = cat.photo

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let CatViewController = segue.destinationViewController as! WebOrderViewController
        
        if let selectedOperationCell = sender as? CatTableViewCell {
            let indexPath = tableView.indexPathForCell(selectedOperationCell)!
            CatViewController.link = catItems[indexPath.row].link
        }
    }


}
