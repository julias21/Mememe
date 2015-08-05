//
//  DisplayMemeViewController.swift
//  MemeMe
//
//  Created by Julia Stefani on 8/3/15.
//  Copyright (c) 2015 Julia Stefani. All rights reserved.
//

import Foundation
import UIKit

class DisplayMemeViewController: UIViewController {
    
    @IBOutlet var MemeView: UIImageView!
    var meme:Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MemeView.image = meme!.memedImage
    }
    
}
