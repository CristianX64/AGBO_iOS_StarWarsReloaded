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

class DTCStarWarsUniverseViewController: UITableViewController {

    // MAKE - Properties
    var model:DTCStarWarsUniverse
    
    
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
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
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
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == imperialSection){
            return self.model.imperialCount;
        }
        else{
            return self.model.rebelCount;
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        // Model for indexPath
        var character:DTCStarWarsCharacter = characterAtIndexPath(indexPath)
        
        // Configure the cell for indexPath
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: kCellIdentifier)            
        cell.imageView?.image = character.image
        cell.textLabel?.text = character.alias
        cell.detailTextLabel?.text = character.name

        // Make sure the constraints have been added to this cell, since it may have just been created from scratch
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
            
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
        var character:DTCStarWarsCharacter = characterAtIndexPath(indexPath)
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
