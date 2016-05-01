//
//  Network.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/11/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP
import SWXMLHash

func checkStatus(sender: UIViewController){
    do {
        let opt = try HTTP.GET("https://s3-us-west-2.amazonaws.com/order.osu/status.xml", parameters: nil ,headers: ["Cache-Control" : "private"])
        opt.start { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                dispatch_sync(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Network Error", message: "Check your connection and try again", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default){ action -> Void in
                        checkStatus(sender)
                        })
                    let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
                    let viewController = appDelegate.window!.rootViewController! as UIViewController
                    viewController.presentViewController(alert, animated: true, completion: nil)

                    
                    })
                return //also notify app of failure as needed
            }
            print("opt finished: \(response.description)")
            parseStatus(response.data, sender: sender)
            //print("data is: \(response.data)") access the response of the data with response.data
        }
    } catch let error {
        print("got an error creating the request: \(error)")
        dispatch_sync(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: "Network Error", message: "Check your connection and try again", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default){ action -> Void in
                checkStatus(sender)
                })
            let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
            let viewController = appDelegate.window!.rootViewController! as UIViewController
            viewController.presentViewController(alert, animated: true, completion: nil)
            })
    }
}

func parseStatus(data: NSData?, sender: UIViewController){

    let xml = SWXMLHash.parse(data!)
    let status = xml["root"]["status"].element?.text
    let enabled = xml["root"]["enabled"].element?.text
    let alert = xml["root"]["alert"].element?.text
    
    if (status != "ok"){
        dispatch_sync(dispatch_get_main_queue(),  {
            let alert = UIAlertController(title: alert, message: status, preferredStyle: UIAlertControllerStyle.Alert)
            if (enabled == "true"){
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            }
            let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
            let viewController = appDelegate.window!.rootViewController! as UIViewController
            viewController.presentViewController(alert, animated: true, completion: nil)
        })
    }

}