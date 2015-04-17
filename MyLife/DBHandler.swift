//
//  DBHandler.swift
//  MyLife
//
//  Created by Guest User on 17/04/15.
//  Copyright (c) 2015 Guest User. All rights reserved.
//

import Foundation
import UIKit

class DBHandler {
    init () {
        SD.executeChange("CREATE TABLE post (PostId INTEGER PRIMARY KEY AUTOINCREMENT, Title TEXT, Text TEXT, Date DATE, VoicePath TEXT)");
        SD.createTable("media", withColumnNamesAndTypes: ["PostId": .IntVal, "Media": .StringVal]);
    }
    
    func deleteDb () {
        NSLog("Deletin' dat fuckin' DB");
        SD.deleteTable("post");
        SD.deleteTable("media");
    }
    
    func savePost(title: String, text: String, date: NSDate, voicepath: String, media: [UIImage]) -> Int {
        if let err = SD.executeChange("INSERT INTO post (Title, Text, Date, VoicePath) VALUES (?, ?, ?, \"\")", withArgs: [title, text, date]) {
            NSLog("Inserting post failed");
            return -1;
        }
        var rowId = SD.lastInsertedRowID();
        for i in media {
            if let err = SD.executeChange("INSERT INTO media (PostId, Media) VALUES (?, ?)", withArgs: [rowId.rowID, i]) {
                NSLog("Inserting media failed");
                return -1;
            }
        }
        return 0;
    }
    
    func savePost(post: Post) -> Int {
        return savePost(post.title, text: post.text, date: post.date, voicepath: post.voicepath, media: post.media);
    }
    
    func retrieveMedia(rowId: Int) -> (err: Bool, media: [UIImage]) {
        var media = [UIImage]();
        var isSuccess = true;
        let (resultSet, err) = SD.executeQuery("SELECT * FROM media WHERE PostId = ?", withArgs: [rowId]);
        if err != nil {
            NSLog("Retrieving media failed");
            isSuccess = false;
        }
        
        for row in resultSet {
            if let image = row["Media"]?.asUIImage() {
                media.append(image);
            } else {
                NSLog("Retrieving image from media failed");
                isSuccess = false;
            }
        }
        return (isSuccess, media);
    }
    
    func retrievePost(row: SD.SDRow) -> (success: Bool, post: Post) {
        var post = Post ();
        var isSuccess = true;
        if let title = row["Title"]?.asString() {
            post.title = title;
        } else {
            post.title = "";
            NSLog("Retrieving title failed");
            isSuccess = false;
        }
        if let title = row["Text"]?.asString() {
            post.text = title;
        } else {
            post.text = "";
            NSLog("Retrieving text failed");
            isSuccess = false;
        }
        if let title = row["Date"]?.asDate() {
            post.date = title;
        } else {
            post.date = NSDate();
            NSLog("Retrieving date failed");
            isSuccess = false;
        }
        if let title = row["VoicePath"]?.asString() {
            post.voicepath = title;
        } else {
            post.voicepath = "";
            NSLog("Retrieving voicepath failed");
            isSuccess = false;
        }
        if let rowid = row["PostId"]?.asInt() {
            let (success, media) = retrieveMedia(rowid);
            post.media = media;
            isSuccess = isSuccess && success;
        } else {
            post.media = [UIImage]();
            NSLog("Retrieving media in post failed");
            isSuccess = false;
        }
        return (isSuccess, post);
    }
    
    func retrievePosts() -> (success: Bool, posts: [Post]){
        var posts = [Post]();
        var isSuccess = true;
        let (resultSet, err) = SD.executeQuery("SELECT rowid, * FROM post");
        if err != nil {
            return (false, posts);
        } else {
            for row in resultSet {
                let (success, post) = retrievePost(row);
                if success {
                    posts.append(post);
                } else {
                    NSLog("Retrieving single post failed");
                    isSuccess = false;
                }
            }
        }
        return (isSuccess, posts);
    }

}