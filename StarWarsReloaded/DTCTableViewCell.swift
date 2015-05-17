//
//  DTCTableViewCell.swift
//  StarWarsReloaded
//
//  Created by David de Tena on 17/05/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

import UIKit

class DTCTableViewCell: UITableViewCell {

    @IBOutlet weak var picture:UIImageView?
    @IBOutlet weak var alias:UILabel?
    @IBOutlet weak var name:UILabel?
    
    static var cellId:String{
        get{
            return "DTCTableViewCell"
        }
    }
    
    // Custom height
    class var height:CGFloat{
        get{
            return 74
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
