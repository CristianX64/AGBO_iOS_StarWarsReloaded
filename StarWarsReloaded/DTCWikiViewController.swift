//
//  DTCWikiViewController.swift
//  StarWarsReloaded
//
//  Created by David de Tena on 16/05/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

import UIKit
let characterDidChangeNotificationName = "newCharacterWiki"
let characterDidChangeNotificationKey = "character"

class DTCWikiViewController: UIViewController,UIWebViewDelegate {

    // MARK - Properties
    var model:DTCStarWarsCharacter
    @IBOutlet weak var browser:UIWebView?
    @IBOutlet weak var activityView:UIActivityIndicatorView?
    
    var canLoad:Bool = true
    
    
    // MARK: - Init
    init(model: DTCStarWarsCharacter){
        self.model = model
        super.init(nibName: "DTCWikiViewController", bundle: nil)        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - View lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Suscribe to notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifyThatCharacterDidChange:", name: characterDidChangeNotificationName, object: nil)
        
        // Load UI
        syncViewWithModel()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set delegate
        self.browser?.delegate = self
    }
    
    

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unsuscribe from notifications
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    // MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UI
    func syncViewWithModel(){
        self.title = self.model.alias + "'s Wiki"
        
        self.canLoad = true
        activityView?.hidden = false
        activityView?.startAnimating()
        
        // Load url in browser
        var url:NSURL? = NSURL(string:self.model.url)
        if let aURL = url{
            var req:NSURLRequest? = NSURLRequest(URL: aURL)
            
            if let aRequest = req{
                self.browser?.loadRequest(aRequest)
            }
        }
    }
    
    
    // MARK: - UIWebViewDelegate
    
    // User cannot navigate through links
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return self.canLoad
    }
    
    // Hides activity view when url loaded
    func webViewDidFinishLoad(webView: UIWebView) {
        self.activityView?.hidden = true
        self.activityView?.stopAnimating()
        
        // Forms or click not allowed
        self.canLoad = false
    }
    
    // Displays an alert if error
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        
        // Ignore error -999
        if(error.code != NSURLErrorCancelled){
            var alertView:UIAlertView = UIAlertView(title: "Error", message: error.localizedDescription, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Done")
            
            self.activityView?.hidden = true
            self.activityView?.stopAnimating()
            
            alertView.show()
        }
    }
    
    
    
    // MARK: - Notifications
    // Update model when notification received
    func notifyThatCharacterDidChange(notification: NSNotification){
        
        var url:NSURL? = NSURL(string:self.model.url)
        
        if let aURL = url{
            var req:NSURLRequest? = NSURLRequest(URL: aURL)
            
            if let aRequest = req{
                self.browser?.loadRequest(aRequest)
            }
        }
        
        var dict:NSDictionary? = notification.userInfo
        if let dictionary = dict{
            
            // Get new character
            var model:DTCStarWarsCharacter = dictionary.valueForKey(characterDidChangeNotificationKey) as! DTCStarWarsCharacter
            self.model = model
            syncViewWithModel()
        }
    }
}
