//
//  DTCWikiViewController.swift
//  StarWarsReloaded
//
//  Created by David de Tena on 16/05/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

import UIKit

class DTCWikiViewController: UIViewController,UIWebViewDelegate {

    // MARK - Properties
    var model:DTCStarWarsCharacter
    @IBOutlet weak var browser:UIWebView?
    @IBOutlet weak var activityView:UIActivityIndicatorView?
    
    
    
    // MARK: - Init
    init(model: DTCStarWarsCharacter){
        self.model = model
        super.init(nibName: "DTCWikiViewController", bundle: nil)
        self.title = self.model.alias + "'s Wiki"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set delegate
        self.browser?.delegate = self
        
        // Load UI
        syncViewWithModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UI
    func syncViewWithModel(){
        activityView?.hidden = false
        activityView?.startAnimating()
        
        var url:NSURL? = NSURL(string:self.model.url)
        
        if let aURL = url{
            var req:NSURLRequest? = NSURLRequest(URL: aURL)
            
            if let aRequest = req{
                self.browser?.loadRequest(aRequest)
            }
        }
    }
    
    
    // MARK: - UIWebViewDelegate
    
    // Hides activity view when url loaded
    func webViewDidFinishLoad(webView: UIWebView) {
        self.activityView?.hidden = true
        self.activityView?.stopAnimating()
    }
    
    // Displays an alert if error
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        var alertView:UIAlertView = UIAlertView(title: "Error", message: "Error when loading Wiki url", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Done")
        
        alertView.show()
        
    }
}
