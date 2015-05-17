//
//  DTCStarWarsUniverseViewController.swift
//  StarWarsReloaded
//
//  Created by David de Tena on 14/05/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

import UIKit

let imperialSection:Int = 0
let rebelSection:Int = 1
let kCellIdentifier = "CellIdentifier"
let lastCharacterSection = "LAST_SELECTED_SECTION"
let lastCharacterRow = "LAST_SELECTED_ROW"




// MARK: - Protocol definition
// Setup custom protocol with a method so we let the characterVC know that a new character has been tapped
protocol DTCStarWarsUniverseViewControllerDelegate{
    
    // Functions
    func starWarsUniverseViewController(swvc: DTCStarWarsUniverseViewController, didSelectCharacter: DTCStarWarsCharacter)
}

// MARK: - Class definition
class DTCStarWarsUniverseViewController: UITableViewController,DTCStarWarsUniverseViewControllerDelegate {

    // MAKE - Properties: model and delegate
    var model:DTCStarWarsUniverse
    var delegate:DTCStarWarsUniverseViewControllerDelegate?
    
    
    // INIT
    init(model:DTCStarWarsUniverse){
        self.model = model
        super.init(nibName:nil, bundle: nil)
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Star Wars Reloaded"
        
        //Register our custom cell as the cell to use in the table view
        var nib:UINib = UINib(nibName: "DTCTableViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: DTCTableViewCell.cellId)
        
        self.tableView.backgroundColor = UIColor(red: 67.0/255.0, green: 67.0/255.0, blue: 67.0/255.0, alpha: 1)
        
        // This will remove extra separators from tableview
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    // Two sections: imperials and rebels
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // Number of rows for each section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == imperialSection){
            return self.model.imperialCount;
        }
        else{
            return self.model.rebelCount;
        }
    }
    
    // Custom height for cell
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return DTCTableViewCell.height
    }

    // Character to be displayed when a cell is tapped
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        // Model for indexPath
        var character:DTCStarWarsCharacter = characterAtIndexPath(indexPath)
        
        // Configure the cell for indexPath
        let cell:DTCTableViewCell = tableView.dequeueReusableCellWithIdentifier(DTCTableViewCell.cellId) as! DTCTableViewCell
        cell.picture?.image = character.image
        cell.alias?.text = character.alias
        if(character.name==""){
            cell.name?.text = "Unknown name"
        }
        else{
            cell.name?.text = character.name
        }
            
        return cell
    }
    
    
    // Headers
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == imperialSection){
            return "Imperials"
        }
        else{
            return "Rebels"
        }
    }
    
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Deselect highlighted
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        // Get current character
        var character:DTCStarWarsCharacter = characterAtIndexPath(indexPath)
        
        // Ask characterVC to upload the model through a protocol method
        // For phones, auto-delegate
        delegate?.starWarsUniverseViewController(self,didSelectCharacter:character)
        
        // Sent a notification to let know that the model changed
        notifyThatCharacterDidChange(character)
        
        // Save last selected character to NSUserDefaults
        saveLastCharacter(indexPath)
        
        // Reload the affected row
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }

    
    
    // MARK - Utils
    func characterAtIndexPath(indexPath: NSIndexPath) -> DTCStarWarsCharacter{
        
        if(indexPath.section == imperialSection){
            var character:DTCStarWarsCharacter = self.model.imperialAtIndex(indexPath.row)
            return character
        }
        else{
            var character:DTCStarWarsCharacter = self.model.rebelAtIndex(indexPath.row)
            return character
        }
    }
    
    
    
    // MARK: - Notifications
    
    // Notification to let know that the model changed
    func notifyThatCharacterDidChange(character: DTCStarWarsCharacter){
        var notification:NSNotification = NSNotification(name: characterDidChangeNotificationName, object: self, userInfo: [characterDidChangeNotificationKey:character])
        
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    
    // MARK: - DTCStarWarsUniverseViewControllerDelegate
    func starWarsUniverseViewController(swvc: DTCStarWarsUniverseViewController, didSelectCharacter: DTCStarWarsCharacter){
        
        // Push the characterVC when tapping on a cell in phones
        var characterVC:DTCCharacterViewController = DTCCharacterViewController(model: didSelectCharacter)
        self.navigationController?.pushViewController(characterVC, animated: true)
    }
    
    // MARK: - Save to disk
    func saveLastCharacter(indexPath: NSIndexPath){
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(indexPath.section, forKey: lastCharacterSection)
        defaults.setInteger(indexPath.row, forKey: lastCharacterRow)
        
        defaults.synchronize()
    }
    
}
