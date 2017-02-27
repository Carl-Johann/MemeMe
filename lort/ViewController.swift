//
//  ViewController.swift
//  MemeMe
//
//  Created by CarlJohan on 01/01/17.
//  Copyright © 2017 Carl-Johan. All rights reserved.
//

import UIKit

class MakeAMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
   
    // MARK: - IBOutlets 
    
    @IBOutlet var shareButton: UIBarButtonItem!
    @IBOutlet var toolbarOutlet: UIToolbar!
    @IBOutlet var buttomMemeTextField: UITextField!
    @IBOutlet var topMemeTextField: UITextField!
    @IBOutlet var CameraButton: UIBarButtonItem!
    @IBOutlet var ChosenImage: UIImageView!
    @IBOutlet var CancelButton: UIBarButtonItem!
    @IBOutlet var TopOutletBar: UINavigationBar!
    
    
    
    // MARK: - View Loads and disapparences
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        subscribeToHideKeyboardNotifications()
        
        topMemeTextField.defaultTextAttributes = memeTextAttributes
        buttomMemeTextField.defaultTextAttributes = memeTextAttributes
        
        topMemeTextField.text = "TYPE HERE"
        buttomMemeTextField.text = "TYPE HERE"
        
        self.topMemeTextField.delegate = self
        self.buttomMemeTextField.delegate = self
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        buttomMemeTextField.alpha = 0
        topMemeTextField.alpha = 0
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromHideKeyboardNotifications()
    }
    
    
    // MARK: - Keyboard
    
    func keyboardWillShow(_ notification:Notification) {
        toolbarOutlet.isHidden = true
        if buttomMemeTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification) + 50
        }
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillHide(_ notification:Notification)  {
        toolbarOutlet.isHidden = false
        if buttomMemeTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    
    // MARK: - Subscriptions
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
    }
    
    func subscribeToHideKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    
    func unsubscribeFromHideKeyboardNotifications() {
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
        
    }
    
    
    
    
    
    // MARK: - The Picture
    
    @IBAction func cameraButton(_ sender: Any) {
        imageChooser(.camera)
    }
    
    func imageChooser(_ type: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            ChosenImage.image = image
            topMemeTextField.alpha = 1
            buttomMemeTextField.alpha = 1
            shareButton.isEnabled = true
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
   
    
    
    
    @IBAction func imagePicker(_ sender: Any) {
        imageChooser(.photoLibrary)
    }

    
    // MARK: - CancelButton
    
    @IBAction func CancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
   
   // MARK: - Meme Text and Font
    
    let memeTextAttributes:[String:Any] = [
        
        //NSStrokeColorAttributeName: UIColor.white,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 25)!,
        NSStrokeWidthAttributeName: 0
    
    ]
    
    // MARK: - Making the meme
    
    @IBAction func shareButton(_ sender: Any) {
    
        //Create a memed image, pass it to the activity view controller.
        let memedImage = self.generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        //If the user completes an action in the activity view controller,
        //save the meme to the shared storage.
        activityVC.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save(memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    func generateMemedImage() -> UIImage {
        
        self.toolbarOutlet.isHidden = true
        self.TopOutletBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.toolbarOutlet.isHidden = false
        self.TopOutletBar.isHidden = false
        
        return memedImage
    }
    
    
    func save(_ memedImage: UIImage) {
        
        let meme = Meme(topText: topMemeTextField.text!, bottomText: buttomMemeTextField.text!, originalImage: ChosenImage.image!, memedImage: memedImage )
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        
    }
}

