//
//  Singleton.swift
//  MyLife
//
//  Created by Guest User on 17/04/15.
//  Copyright (c) 2015 Guest User. All rights reserved.
//

import Foundation
import UIKit

class Singleton {
    
    var db: DBHandler;
    
    init(){
        self.db = DBHandler();
    }
    
    class var sharedInstance: Singleton {
        struct Static {
            static var instance: Singleton?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Singleton()
        }
        
        return Static.instance!
    }
    
}
