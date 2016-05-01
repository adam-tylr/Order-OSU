//
//  OrderDetailViewController.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/12/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit
import WebKit

class OrderDetailViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView?
    var loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func loadView() {
        super.loadView()
        self.webView = WKWebView()
        self.webView?.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(self.webView!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView?.navigationDelegate = self
        
        // Add loading icon
        loadingIndicator.center = self.view.center
        self.view.addSubview(loadingIndicator)
        
        // Load the order
        let defaults = NSUserDefaults.standardUserDefaults()
        if let link = defaults.stringForKey("lastOrder"){
            let url = NSURL(string: link)!
            let request = NSURLRequest(URL: url)
            self.webView!.loadRequest(request)
        }else{
            let alert = UIAlertController(title: "No History Availible", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            navigationController?.popViewControllerAnimated(true)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingIndicator.startAnimating()
    }
    
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        let script = "var stylenode = document.createElement('style');var styletext = '#banner{display: none;}#navScrollArea{display: none;}#fullSiteLink{display: none;}#functions{display: none;}#catShare{display: none;}#headerFunctions{display: none;}';stylenode.appendChild(document.createTextNode(styletext));document.getElementsByTagName('head')[0].appendChild(stylenode);"
        //let script = "document.documentElement.innerHTML"
        self.webView!.evaluateJavaScript(script, completionHandler: { (response, error) in
            // this is where the completion handler code goes
        })
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        
        loadingIndicator.stopAnimating()
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
