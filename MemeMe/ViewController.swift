//
//  ViewController.swift
//  MemeMe
//
//  Created by Julia Stefani on 7/21/15.
//  Copyright (c) 2015 Julia Stefani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var Photos: UIBarButtonItem!
    @IBOutlet weak var Camera: UIBarButtonItem!
    @IBOutlet weak var Showpicture: UIImageView!
    @IBOutlet weak var ShareButton: UIBarButtonItem!
    @IBOutlet weak var Top: UITextField!
    @IBOutlet weak var Bottom: UITextField!
    var meme: UIImage!
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!,
        NSStrokeWidthAttributeName : -2.0,
    ]
    
    override func viewDidLoad() {
       
       
        super.viewDidLoad()
        Top.delegate =  self
        Bottom.delegate = self
        Bottom.textAlignment = .Center
        Top.defaultTextAttributes = memeTextAttributes
        Bottom.defaultTextAttributes = memeTextAttributes
        Top.text = "TOP"
        Top.textAlignment = .Center
        Bottom.text = "BOTTOM"
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        Camera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        
    }
    
    
   //action based functions

    @IBAction func PickphotofromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func PickphotofromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    


    @IBAction func sharememe(sender: AnyObject) {
 
let memedImage = generateMemedImage()
let ActivityViewController = UIActivityViewController(activityItems:[memedImage], applicationActivities: nil)
ActivityViewController.completionWithItemsHandler = { (_, _, _, _) in
    self.dismissViewControllerAnimated(true, completion: nil)
}

self.presentViewController(ActivityViewController, animated: true, completion: nil)
save()
}



    @IBAction func cancel(sender: AnyObject){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            Showpicture.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    //Show/hide keyboard
    
    // keyboard dismiss when return is pressed (fixing comment from 1st submission)
   func textFieldShouldReturn(textField: UITextField) -> Bool {
       Top.resignFirstResponder()
       Bottom.resignFirstResponder()
       return true
   }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
                UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if Bottom.isFirstResponder() {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
       
       }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if Bottom.isFirstResponder(){
        self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
  
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //saving
    
    func save() {
        //Create the meme
        var meme = Meme(topText: Top.text!, bottomText: Bottom.text!, image:Showpicture.image!, memedImage: generateMemedImage())
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
        }


    //generating the meme
    
    func generateMemedImage() -> UIImage
    {
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
}

