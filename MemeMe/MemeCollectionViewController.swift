//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Julia Stefani on 7/27/15.
//  Copyright (c) 2015 Julia Stefani. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UICollectionViewController, UICollectionViewDataSource {


var memes: [Meme]!

    //code from clas lesson
override func viewWillAppear(animated:Bool) {
  super.viewWillAppear(animated)
    
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate
    self.memes = appDelegate.memes
    self.collectionView?.reloadData()
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        var cell : MemeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! MemeCollectionViewCell //Error throws here
        let meme: Meme = self.memes[indexPath.row] as Meme
        cell.PhotoCell.image = meme.memedImage

        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
    }

  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
       if (segue.identifier == "collectionviewToDisplay") {
     let destVC:DisplayMemeViewController = segue.destinationViewController as! DisplayMemeViewController
       var indexPath = NSIndexPath()
        destVC.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(destVC, animated: true)
        }
    }
}