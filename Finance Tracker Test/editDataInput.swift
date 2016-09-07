//
//  editDataInput.swift
//  Finance Tracker Test
//
//  Created by Mengyao Liu on 11/29/15.
//  Copyright © 2015 University of Iowa. All rights reserved.
//

import Foundation
import UIKit

class editDataInput: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var image:Images = Images()
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var theBalanceAmount: UILabel!
    
    var collectionView: receiptsCollectionViewController = receiptsCollectionViewController()
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        theBalanceAmount.text = "$\(balance)"
        
        amountOfItem.keyboardType = UIKeyboardType.DecimalPad
        desctriptionOfItem.layer.borderColor = UIColor.lightGrayColor().CGColor
        desctriptionOfItem.layer.borderWidth = 0.8
        titleOfItem.layer.borderColor = UIColor.lightGrayColor().CGColor
        titleOfItem.layer.borderWidth = 0.8
        amountOfItem.layer.borderColor = UIColor.lightGrayColor().CGColor
        amountOfItem.layer.borderWidth = 0.8
        locationOfItem.layer.borderColor = UIColor.lightGrayColor().CGColor
        locationOfItem.layer.borderWidth = 0.8
        
        titleOfItem.text = theTitle
        amountOfItem.text = "\(theAmount)"
        desctriptionOfItem.text = theDescription
        locationOfItem.text = location
        imageView.image = theImage
        categoryLabel.text = category
        
        if repeating == "monthly" {
            monthlySwitch.setOn(true, animated: true)
            
        }else if repeating == "weekly"{
            weeklySwitch.setOn(true, animated: true)
            
        } else if repeating == "daily" {
            dailySwitch.setOn(true, animated: true)
        }else {
            
        }
        
        self.navigationItem.backBarButtonItem?.title = "Cancel"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // Connected to the Take Picture Button
    // Used to capture an image
    // Image is stored as imageFromSource
    @IBAction func pictureButton(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            // If camera is available, use camera
            //imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.sourceType = .Camera
            
            presentViewController(picker, animated: true, completion:  nil )
            
        } else {
            // If camera not available, use photo library (For testing purposes)
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.sourceType = .PhotoLibrary
            
            presentViewController(picker, animated: true, completion:  nil )

        }
    }
    @IBAction func captureImage(sender: UIButton) {

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            // If camera is available, use camera
            //imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.sourceType = .Camera
            
            presentViewController(picker, animated: true, completion:  nil )
            
        } else {
            // If camera not available, use photo library (For testing purposes)
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.sourceType = .PhotoLibrary
            
            presentViewController(picker, animated: true, completion:  nil )
        }
        
    }
    
    // used for thumbnail
    @IBOutlet weak var imageView: UIImageView!
    
    var uploadImage: UIImage = UIImage(named: "no_image.jpg")!
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        
        // selectedImage is the image that was taken
        // save this to the data structure
        let selectedImage : UIImage = image
        uploadImage = image
        print(selectedImage.description, terminator: "")
        imageView.image = selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func monthlySwitchWasChanged(sender: UISwitch) {
        weeklySwitch.setOn(false, animated: true)
        dailySwitch.setOn(false, animated: true)
    }
    @IBAction func weeklySwitchWasChanged(sender: UISwitch) {
        monthlySwitch.setOn(false, animated: true)
        dailySwitch.setOn(false, animated: true)
    }
    
    @IBAction func dailySwitchWasChanged(sender: UISwitch) {
        monthlySwitch.setOn(false, animated: true)
        weeklySwitch.setOn(false, animated: true)
    }
    
    // repeat switches
    @IBOutlet weak var monthlySwitch: UISwitch!
    @IBOutlet weak var weeklySwitch: UISwitch!
    @IBOutlet weak var dailySwitch: UISwitch!
    
    // Text fields that the user fills out
    @IBOutlet weak var titleOfItem: UITextField!
    @IBOutlet weak var amountOfItem: UITextField!
    @IBOutlet weak var desctriptionOfItem: UITextView!
    @IBOutlet weak var locationOfItem: UITextField!
    
    var theTitle:String = "No Title"
    var theAmount:Double = 0.0
    var theDescription:String = ""
    var location:String = ""
    var category: String = ""
    var indexRow: Int = 0
    var repeating:String = ""
    var dateString:String = ""
    
    var theImage: UIImage = UIImage(named: "no_image.jpg")!.imageRotatedByDegrees(-90, flip: false)
    
    // once save is pressed, send values to data structure
    @IBAction func saveWasPressed(sender: UIButton) {
        print("saved was pressed", terminator: "")
        
        // used with switches to tell when to repeat
        var repeatWhen : String = "none"
        
        // decides repeat behavior
        if( dailySwitch.on == true){
            repeatWhen = "daily"
        } else if( weeklySwitch.on == true ) {
            repeatWhen = "weekly"
        } else if( monthlySwitch.on == true ) {
            repeatWhen = "monthly"
        }
        
        if imageView.image! == theImage {
            image.editItemToImagesArray( dateString, imageName: imageView.image!.imageRotatedByDegrees(-90, flip: false), category: category, heading: titleOfItem.text!, amount: (amountOfItem.text! as NSString).doubleValue , location: locationOfItem.text!, description: desctriptionOfItem.text, repeating: repeatWhen, index: indexRow )
        } else {
            image.editItemToImagesArray( dateString, imageName: imageView.image!, category: category, heading: titleOfItem.text!, amount: (amountOfItem.text! as NSString).doubleValue , location: locationOfItem.text!, description: desctriptionOfItem.text, repeating: repeatWhen, index: indexRow )
        }
        
        
        
        print( titleOfItem.text, terminator: "" )
        print( amountOfItem.text, terminator: "" )
        print( desctriptionOfItem.text, terminator: "" )
        print( locationOfItem.text, terminator: "" )
        print( repeatWhen, terminator: "" )
        
        balance = balance - (amountOfItem.text! as NSString).doubleValue
        
        // when save is pressed, append to datastructure
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}
