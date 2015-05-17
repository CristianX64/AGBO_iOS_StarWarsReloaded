//
//  DTCCharacterViewController.swift
//  StarWarsReloaded
//
//  Created by David de Tena on 12/05/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class DTCCharacterViewController: UIViewController, UISplitViewControllerDelegate, DTCStarWarsUniverseViewControllerDelegate {

    // MARK - Properties
    var model:DTCStarWarsCharacter
    var audioPlayer: AVAudioPlayer?
    
    // MAKE - Outlets
    @IBOutlet weak var imageView: UIImageView!

    
    // MARK: - Init
    init(model: DTCStarWarsCharacter){
        self.model = model
        super.init(nibName: "DTCCharacterViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set left (or right) button item that shows or hides the table
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        
        // Sync view with model data
        syncViewWithModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Sync UI
    func syncViewWithModel(){
        imageView.image = self.model.image
        self.title = self.model.alias
    }

    
    // MARK: - Action methods    
    
    // Plays character's sound when tapping play button
    @IBAction func playSound(sender: AnyObject) {

        let path = NSBundle.mainBundle().pathForResource(self.model.sound, ofType:"caf")
        let fileURL = NSURL(fileURLWithPath: path!)
        
        var error: NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: &error)
        if let err = error {
            println("audioPlayer error \(err.localizedDescription)")
        } else {
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
    }
    
    // Display character's info in Wikipedia when tapping wiki button
    @IBAction func goToWikipedia(sender: AnyObject) {
        var wikiVC:DTCWikiViewController = DTCWikiViewController(model: self.model)
        self.navigationController?.pushViewController(wikiVC, animated: true)
    }
    
    
    // MARK - UISplitViewControllerDelegate
    func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        if(displayMode == UISplitViewControllerDisplayMode.PrimaryHidden){
            self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem()
        }
        else{
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    
    // MARK: - DTCStarWarsUniverseViewControllerDelegate
    func starWarsUniverseViewController(swvc: DTCStarWarsUniverseViewController, didSelectCharacter: DTCStarWarsCharacter){
        // Update UI with new model
        self.model = didSelectCharacter
        syncViewWithModel()
    }
    
}
