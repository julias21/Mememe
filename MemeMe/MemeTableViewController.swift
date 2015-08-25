//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Julia Stefani on 7/27/15.
//  Copyright (c) 2015 Julia Stefani. All rights reserved.
//

import Foundation

import UIKit

class MemeTableViewController : UITableViewController, UITableViewDataSource {

    var memes: [Meme]!

    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        self.memes = appDelegate.memes
        self.tableView.reloadData()
    }
    
 
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:MemeTableViewCell = tableView.dequeueReusableCellWithIdentifier("memeIdentifier") as! MemeTableViewCell
        let meme:Meme = self.memes[indexPath.row] as Meme
        cell.MemeImageView.image = meme.memedImage
      
        return cell
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tableviewToDisplay") {
            let destVC:DisplayMemeViewController = segue.destinationViewController as! DisplayMemeViewController
            
            var indexPath = self.tableView.indexPathForSelectedRow()!
            let meme:Meme = self.memes[indexPath.row] as Meme
            destVC.meme = meme
        }
    }
    
    
    
}
