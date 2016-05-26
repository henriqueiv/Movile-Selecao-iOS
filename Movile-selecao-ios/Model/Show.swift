//
//  Model.swift
//  Movile-selecao-ios
//
//  Created by Henrique Valcanaia on 2/26/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Foundation

struct Show {
    
    var title = ""
    var watchers = 0
    var imageURL = NSURL()
    
    init(dictionary: [String:AnyObject]) {
        if let showDictionary = dictionary["show"] as? [String:AnyObject]{
            title = showDictionary["title"] as! String
            
            if let imagesDictionary = showDictionary["images"] as? [String:AnyObject],
                let posterDictionary = imagesDictionary["poster"] as? [String:String],
                let stringURL = posterDictionary["thumb"] {
                imageURL = NSURL(string: stringURL)!
            }
        }
        
        if let watchers = dictionary["watchers"] as? Int {
            self.watchers = watchers
        }
    }
    
}