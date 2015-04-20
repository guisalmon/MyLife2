//
//  AddViewController.swift
//  MyLife
//
//  Created by Guest User on 20/04/15.
//  Copyright (c) 2015 Guest User. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var dateView: UITextView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mediaTableView: UITableView!
    
    var post: Post!
    var media: [UIImage]!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        post = Post()
        media = [UIImage]()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPublishClicked(sender: AnyObject) {
        post.title = titleView.text
        post.text = textView.text
        post.date = NSDate();
        post.media = media
    }
    
    @IBAction func onPhotoClicked(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onGalleryClicked(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onVoiceClicked(sender: AnyObject) {
    }
    
    @IBAction func onVideoClicked(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        imagePicker.mediaTypes = [kUTTypeMovie]
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        
        cell.textLabel!.text = post.title
    }
    
}