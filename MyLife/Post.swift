//
//  Post.swift
//  MyLife
//
//  Created by Guest User on 17/04/15.
//  Copyright (c) 2015 Guest User. All rights reserved.
//

import Foundation
import UIKit

class Post {
    var title: String;
    var text: String;
    var date: NSDate;
    var voicepath: String;
    var media:[UIImage];
    
    init (title: String, text:String, date: NSDate, voicepath: String, media: [UIImage]){
        self.title = title;
        self.text = text;
        self.date = date;
        self.voicepath = voicepath;
        self.media = media;
    }
    
    init () {
        self.title = "";
        self.text = "";
        self.date = NSDate();
        self.voicepath = "";
        self.media = [UIImage]();
    }
    
    func toString() -> String {
        var result = "Title: "+self.title;
        result += ", Text: "+self.text;
        var dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "dd:MM:yy hh:mm";
        result += ", Date: "+dateFormatter.stringFromDate(self.date);
        result += ", Voice: "+self.voicepath;
        return result;
    }
    
    
}
