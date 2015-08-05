//
//  Meme.swift
//  MemeMe
//
//  Created by Julia Stefani on 7/21/15.
//  Copyright (c) 2015 Julia Stefani. All rights reserved.
//

import Foundation
import UIKit

class Meme{
    var top: String
    var bottom: String
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, image:
        UIImage, memedImage: UIImage){
            
            self.top = topText
            self.bottom = bottomText
            self.image = image
            self.memedImage = memedImage
    }
}
