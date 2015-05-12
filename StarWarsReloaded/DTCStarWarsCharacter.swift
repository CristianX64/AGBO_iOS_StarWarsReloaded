//
//  DTCStarWarsCharacter.swift
//  StarWarsReloaded
//
//  Created by David de Tena on 12/05/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

import UIKit

class DTCStarWarsCharacter: NSObject {
    
    // Properties
    var name:String
    var alias:String
    var image:UIImage
    var sound:NSData
    var url:NSURL
    
    
    // Inits
    init(name:String, alias:String, image:UIImage, sound:NSData, url:NSURL){
        self.name = name
        self.alias = alias
        self.image = image
        self.sound = sound
        self.url = url
    }
}
