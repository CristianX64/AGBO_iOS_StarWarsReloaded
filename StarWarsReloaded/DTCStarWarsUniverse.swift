//
//  DTCStarWarsUniverse.swift
//  StarWarsReloaded
//
//  Created by David de Tena on 14/05/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

import UIKit

class DTCStarWarsUniverse {
    
    // Properties => imperials and rebels groups
    var _imperials = Array<DTCStarWarsCharacter>()
    var _rebels = Array<DTCStarWarsCharacter>()
    
    // Computed properties
    var imperialCount:Int{
        get{
            return _imperials.count
        }
    }
    
    var rebelCount:Int{
        get{
            return _rebels.count
        }
    }

    
    // Init
    init(){
        // Create the models
        
        // Darth Vader
        var vaderImage = UIImage(named: "darthVader.jpg")
        var vaderCharacter = DTCStarWarsCharacter(name: "Anakin Skywalker",
            alias: "Darth Vader",
            image:vaderImage,
            sound: "vader",
            url: "http://en.wikipedia.org/wiki/Darth_Vader")
        
        
        //Tarkin
        var tarkinImage = UIImage(named: "tarkin.jpg")
        var tarkinCharacter = DTCStarWarsCharacter(name: "Wilhuf Tarkin",
            alias: "Grand Moff Tarkin",
            image:tarkinImage,
            sound: "tarkin",
            url: "http://en.wikipedia.org/wiki/Grand_Moff_Tarkin")
        
        
        // Palpatine
        var palpatineImage = UIImage(named: "palpatine.jpg")
        var palpatineCharacter = DTCStarWarsCharacter(
            alias: "Palpatine",
            image:palpatineImage,
            sound: "palpatine",
            url: "http://en.wikipedia.org/wiki/Palpatine")
        
        
        // Chewbacca
        var chewieImage = UIImage(named: "chewbacca.jpg")
        var chewieCharacter = DTCStarWarsCharacter(
            alias: "Chewbacca",
            image:chewieImage,
            sound: "chewbacca",
            url: "http://en.wikipedia.org/wiki/Chewbacca")
        
        
        // C3-PO
        var c3poImage = UIImage(named: "c3po.jpg")
        var c3poCharacter = DTCStarWarsCharacter(
            alias: "C-3PO",
            image:c3poImage,
            sound: "c3po",
            url: "http://en.wikipedia.org/wiki/C-3PO")
        

        // Yoda
        var yodaImage = UIImage(named: "yoda.jpg")
        var yodaCharacter = DTCStarWarsCharacter(name: "Minch Yoda",
            alias: "Master Yoda",
            image:yodaImage,
            sound: "yoda",
            url: "http://en.wikipedia.org/wiki/Yoda")
        
        // R2-D2
        var r2d2Image = UIImage(named: "R2-D2.jpg")
        var r2d2Character = DTCStarWarsCharacter(
            alias: "R2-D2",
            image:r2d2Image,
            sound: "r2-d2",
            url: "http://en.wikipedia.org/wiki/R2-D2")
        
        _imperials = [vaderCharacter,palpatineCharacter,tarkinCharacter];
        _rebels = [chewieCharacter,c3poCharacter,yodaCharacter,r2d2Character];
    }
    
    // Designated
    init(imperials: Array<DTCStarWarsCharacter>, rebels: Array<DTCStarWarsCharacter>){
        self._imperials = imperials
        self._rebels = rebels
    }
    
    
    // Functions
    func imperialAtIndex(index:Int) -> DTCStarWarsCharacter{
        return _imperials[index]
    }
    
    func rebelAtIndex(index:Int) -> DTCStarWarsCharacter{
        return _rebels[index]
    }
    
}
