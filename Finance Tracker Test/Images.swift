//
//  Images.swift
//  Recent Tab
//
//  Created by Mengyao Liu on 11/2/15.
//  Copyright © 2015 Mengyao Liu. All rights reserved.
//

import Foundation
import UIKit

var startDate = NSDate()
var endDate = NSDate()

extension UIImage {
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let radiansToDegrees: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat(M_PI))
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
        let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        CGContextScaleCTM(bitmap, yFlip, -1.0)
        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

func isFirstTimeOpening() -> Bool {
    let userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    if (userDef.integerForKey("firstTime")) == 0 {
        NSUserDefaults.standardUserDefaults().setObject(1, forKey: "firstTime")
        return true
    } else {
        return false
    }
}


let userDefaults = NSUserDefaults.standardUserDefaults()

class ImagesArray {
    var date:String
    var imageName: String
    var category: String
    var heading: String
    var amount: Double
    var location: String
    var description: String
    var repeating: String
    
    
    init (date: String, imageName: String, category: String, heading: String, amount: Double, location: String, description: String, repeating:String){
        self.date = date
        self.imageName = imageName
        self.category = category
        self.heading = heading
        self.amount = amount
        self.location = location
        self.description = description
        self.repeating = repeating
    }
}
var date: String = "\(NSDate())"
let storedImagesArray = ""

var theImages : [ImagesArray] = []
var isStartUp: Bool = true

var dateArray : [String] = []
var imageArray : [String] = []
var categoryArray : [String] = []
var headingArray : [String] = []
var amountArray : [Double] = []
var locationArray : [String] = []
var descriptionArray : [String] = []
var repeatingArray : [String] = []


func saveDataArray() {
    var index = 0
    
    dateArray = []
    imageArray = []
    categoryArray = []
    headingArray = []
    amountArray = []
    locationArray = []
    descriptionArray = []
    repeatingArray = []
    
    for i in theImages {
        dateArray.append(theImages[index].date)
        imageArray.append(theImages[index].imageName)
        categoryArray.append(theImages[index].category)
        headingArray.append(theImages[index].heading)
        amountArray.append(theImages[index].amount)
        locationArray.append(theImages[index].location)
        descriptionArray.append(theImages[index].description)
        repeatingArray.append(theImages[index].repeating)
        
        index = index + 1
    }
    
    print (theImages)
    
    NSUserDefaults.standardUserDefaults().setObject(dateArray, forKey: "dateArray")
    NSUserDefaults.standardUserDefaults().setObject(imageArray, forKey: "imageArray")
    NSUserDefaults.standardUserDefaults().setObject(categoryArray, forKey: "categoryArray")
    NSUserDefaults.standardUserDefaults().setObject(headingArray, forKey: "headingArray")
    NSUserDefaults.standardUserDefaults().setObject(amountArray, forKey: "amountArray")
    NSUserDefaults.standardUserDefaults().setObject(locationArray, forKey: "locationArray")
    NSUserDefaults.standardUserDefaults().setObject(descriptionArray, forKey: "descriptionArray")
    NSUserDefaults.standardUserDefaults().setObject(repeatingArray, forKey: "repeatingArray")
    
    print("saved!!")

}

func restoreDataArray() {
    
    let userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    dateArray = userDef.arrayForKey("dateArray") as! [String]
    imageArray = userDef.arrayForKey("imageArray") as! [String]
    categoryArray = userDef.arrayForKey("categoryArray") as! [String]
    headingArray = userDef.arrayForKey("headingArray") as! [String]
    amountArray = userDef.arrayForKey("amountArray") as! [Double]
    locationArray = userDef.arrayForKey("locationArray") as! [String]
    descriptionArray = userDef.arrayForKey("descriptionArray") as! [String]
    repeatingArray = userDef.arrayForKey("repeatingArray") as! [String]

    var index = 0
    while (index < dateArray.count) {
        
        let date = dateArray[index]
        let imageName = imageArray[index]
        let category = categoryArray[index]
        let heading = headingArray[index]
        let amount = amountArray[index]
        let location = locationArray[index]
        let description = descriptionArray[index]
        let repeating = repeatingArray[index]
        
        
        
        let image : ImagesArray
        image = ImagesArray( date: date, imageName: imageName, category: category, heading: heading, amount: amount, location: location, description: description, repeating: repeating)
        
        theImages.append(image)
        
        
        index = index + 1
    }

    
}


var balance: Double = 0.0

class Images {
    
    func numberOfImages() -> Int {
        return theImages.count
    }
    
    func dateForIndex(index: Int) -> NSDate{
        let image: ImagesArray = theImages[index]
        let fileName:String =  image.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = dateFormatter.dateFromString(fileName)
        
        return date!
        //return image.date
        //return NSDate()
    }
    
    func dateStringForIndex(index: Int) -> String{
        let image: ImagesArray = theImages[index]
        return image.date
    }
    
    func imageNameForIndex(index: Int) -> UIImage {
        let image: ImagesArray = theImages[index]
        let fileName:String =  image.imageName
        let fileManager = NSFileManager.defaultManager()
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let getImagePath = (paths as NSString).stringByAppendingPathComponent("\(fileName).jpg")
        if (fileManager.fileExistsAtPath(getImagePath)){
            return UIImage(contentsOfFile: getImagePath)!.imageRotatedByDegrees(90, flip: false)
        }
        else{
            return UIImage(contentsOfFile: "no_image.jpg")!
            
        }
        
        
        
        
    }
    
    func categoryForIndex(index: Int) -> String {
        let image: ImagesArray = theImages[index]
        return image.category
    }
    
    func imageHeadingForIndex(index: Int) -> String {
        let image: ImagesArray = theImages[index]
        return image.heading
    }
    
    func imageAmountForIndex(index: Int) -> Double {
        let image: ImagesArray = theImages[index]
        return image.amount
    }
    
    func imageLocationForIndex(index: Int) -> String {
        let image: ImagesArray = theImages[index]
        return image.location
    }
    
    func imageDescriptionForIndex(index: Int) -> String {
        let image: ImagesArray = theImages[index]
        return image.description
    }
    
    func repeatingForIndex(index: Int) -> String {
        let image: ImagesArray = theImages[index]
        return image.repeating
    }
    
    func lengthOfImagesArray() -> Int {
        let image: Int = theImages.count
        return image
    }
    
    func saveImages(UIImageName: UIImage, fileName: String) {
        let selectedImage: UIImage = UIImageName
        
        
        let fileManager = NSFileManager.defaultManager()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let filePathToWrite = "\(paths)/\(fileName).jpg"
        
        let imageData: NSData = UIImagePNGRepresentation(selectedImage)!
        
        fileManager.createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)
        
        let getImagePath = (paths as NSString).stringByAppendingPathComponent("\(fileName).jpg")
        
        if (fileManager.fileExistsAtPath(getImagePath)){
            print("FILE AVAILABLE");
        }
        else{
            print("FILE NOT AVAILABLE");
            
        }
    }
    
    func addItemToImagesArray( date: NSDate, imageName: UIImage, category: String, heading: String, amount: Double, location: String, description: String, repeating:String){

        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss" //format style. Browse online to get a format that fits your needs.
        let dateString:String = dateFormatter.stringFromDate(NSDate())
        
        let image : ImagesArray
        image = ImagesArray( date: dateString, imageName: dateString, category: category, heading: heading, amount: amount, location: location, description: description, repeating: repeating)
        theImages.append(image)
        saveImages(imageName, fileName: dateString)
        print("\(theImages.count)", terminator: "")

        
        
        
        print("added!!")
        print("\(theImages.count)", terminator: "")
	}
    
    func editItemToImagesArray( date: String, imageName: UIImage, category: String, heading: String, amount: Double, location: String, description: String, repeating:String, index: Int){
        let image : ImagesArray
        
        image = ImagesArray( date: date, imageName: date, category: category, heading: heading, amount: amount, location: location, description: description, repeating: repeating)
        theImages[index] = image
        saveImages(imageName, fileName: date)
        print("\(theImages.count)", terminator: "")
        
    }

    
}
