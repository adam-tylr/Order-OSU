//
//  WebOrderViewController.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/5/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit
import WebKit

class WebOrderViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet var containerView: UIView!
    var webView: WKWebView?
    var loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    var urls = [NSURL]()
    var link = String?()
    var cartLink = String!()
    var forwardClicks = 0;
    var backButton = UIBarButtonItem?()
    
    override func loadView() {
        super.loadView()
        self.webView = WKWebView()
        self.webView?.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 45)
        self.view.addSubview(self.webView!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Add toolbar and view cart button
        let toolbar = UIToolbar()
        let cart = UIBarButtonItem()
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        cart.title = "View Cart"
        cart.action = "viewCart:"
        toolbar.setItems([space,cart,space], animated: false)
        toolbar.frame = CGRectMake(0, self.view.frame.size.height - 45, self.view.frame.size.width, 45)
        self.view.addSubview(toolbar)
        
        // Add webpage back button
        self.backButton = UIBarButtonItem()
        backButton!.title = "Back"
        backButton!.action = "goBackPage:"
        
        // Add back gesture
        let screenEdgeRec = UIScreenEdgePanGestureRecognizer(target: self, action: "goBackPageGesture:")
        screenEdgeRec.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(screenEdgeRec)
        
        // Add loading icon
        loadingIndicator.center = self.view.center
        self.view.addSubview(loadingIndicator)
        
        webView?.navigationDelegate = self
        
        // Load the first page
        if let link = link{
            let url = NSURL(string: link)!
            let request = NSURLRequest(URL: url)
            self.webView!.loadRequest(request)
        }
        

    }
    
    // Called by the view cart button
    func viewCart(sender: UIBarButtonItem){
        if (cartLink != nil){
            let url = NSURL(string: self.cartLink!)!
            let request = NSURLRequest(URL: url)
            self.webView!.loadRequest(request)
        }
    }
    
    // Called by the back button
    func goBackPage(sender: UIBarButtonItem){
        forwardClicks -= 2
        if (forwardClicks <= 1){
            self.navigationItem.leftBarButtonItem = nil
        }
        self.webView?.goBack()
    }
    
    // Called by the back gesture
    func goBackPageGesture(sender: UIScreenEdgePanGestureRecognizer){
        if (sender.state == UIGestureRecognizerState.Ended && forwardClicks > 1){
            forwardClicks -= 2
            if (forwardClicks <= 1){
                self.navigationItem.leftBarButtonItem = nil
            }
            self.webView?.goBack()
        }
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingIndicator.startAnimating()
    }
    
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        let script = "var stylenode = document.createElement('style');var styletext = '#banner{display: none;}#navScrollArea{display: none;}#fullSiteLink{display: none;}#functions{display: none;}#catShare{display: none;}#headerFunctions{display: none;}#content{border:none;}';stylenode.appendChild(document.createTextNode(styletext));document.getElementsByTagName('head')[0].appendChild(stylenode);"
        //let script = "document.documentElement.innerHTML"
        self.webView!.evaluateJavaScript(script, completionHandler: { (response, error) in
            // this is where the completion handler code goes
        })
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        
        loadingIndicator.stopAnimating()
        let script = "var stylenode = document.createElement('style');var styletext = '#content{border:none;}';stylenode.appendChild(document.createTextNode(styletext));document.getElementsByTagName('head')[0].appendChild(stylenode);"
        //let script = "document.documentElement.innerHTML"
        self.webView!.evaluateJavaScript(script, completionHandler: { (response, error) in
            // this is where the completion handler code goes
        })
        
        // Commented script returns entire document body for debugging
        //let script2 = "document.documentElement.innerHTML"
        let script2 = "var tc = document.getElementById('functions');var ary = tc ? tc.getElementsByTagName('a') : [];ary[0].href;"
        self.webView!.evaluateJavaScript(script2, completionHandler: { (response, error) in
            // this is where the completion handler code goes
            if (response != nil){
                self.cartLink = response as! String
            }
            //print(response)
            
        })
        
        // Auto Fill
        let defaults = NSUserDefaults.standardUserDefaults()
        var name = defaults.stringForKey("UserName") as String!
        var phone = defaults.stringForKey("UserPhone") as String!
        var email = defaults.stringForKey("UserEmail") as String!
        if (name == nil){
            name = ""
        }
        if (phone == nil){
            phone = ""
        }
        if (email == nil){
            email = ""
        }
        let script3 = "document.getElementById('billname').value='\(name)';document.getElementById('phone').value='\(phone)';document.getElementById('email').value='\(email)';"
        self.webView!.evaluateJavaScript(script3, completionHandler: { (response, error) in
            // this is where the completion handler code goes
        })
        
        // Back button logic
        forwardClicks++
        if (forwardClicks > 1){
            self.navigationItem.leftBarButtonItem = self.backButton
        }
        
        // Checkout Logic
            let components = NSURLComponents(URL: (self.webView?.URL)!, resolvingAgainstBaseURL: false)
            let queryItems = components?.queryItems
            let response = queryItems?.filter({$0.name == "Response"}).first?.value
            if (response == "accepted"){
                orderComplete()
            }
    }
    
    func orderComplete(){        
        // Return to the main operation menu
        // Create popup alert to confirm order placed
        let alert = UIAlertController(title: "Success!", message: "Your Order has been placed", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { (action) in
            self.performSegueWithIdentifier("backToMain", sender: self)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
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
        
        if segue.identifier == "backToMain"{
            
            let backViewController = segue.destinationViewController as! OperationTableViewController
            
            // Get the cell that generated this segue.
            backViewController.returning = true
            
        }
    }
    

}
