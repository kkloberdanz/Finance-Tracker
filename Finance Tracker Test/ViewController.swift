//
//  ViewController.swift
//  Recent Tab
//
//  Created by Mengyao Liu on 10/31/15.
//  Copyright © 2015 Mengyao Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var headingTitle: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var repeatingLabel: UILabel!
    
    
    
    var imageName:UIImage = UIImage(named: "no_image.jpg")!
    var heading:String = ""
    var amount: Double = 0.0
    var location:String = ""
    var descriptions:String = ""
    var categoryName:String = ""
    var indexRow:Int = 0
    var repeating:String = "None"
    var dateString:String = ""
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if picturePressed {
            let fullScreen:fullScreenImage = segue.destinationViewController as! fullScreenImage
            fullScreen.imageName = imageName
        }else {
            let dataInformation:editDataInput = segue.destinationViewController as! editDataInput
            dataInformation.theTitle = heading
            dataInformation.theAmount = amount
            dataInformation.theDescription = descriptions
            dataInformation.location = location
            dataInformation.category = categoryName
            dataInformation.theImage = imageName
            dataInformation.indexRow = indexRow
            dataInformation.repeating = repeating
            dataInformation.dateString = dateString
            let now = NSDate()
            print(now, terminator: "")
            now.timeIntervalSinceReferenceDate
        }
        
    }

    var picturePressed: Bool = false
    
    @IBAction func ButtonOnPicturePressed(sender: UIButton) {
        picturePressed = true
    }
    @IBAction func EditPressed(sender: UIButton) {
        picturePressed = false
    }

    override func viewDidLoad() {
        picturePressed = false
        super.viewDidLoad()
        headingTitle.text = "Title: " + heading
        detailImage.image = imageName
        amountLabel.text = "Amount: \(amount)"
        locationLabel.text = "Location: " + location
        descriptionLabel.text = descriptions
        category.text = categoryName
        repeatingLabel.text = "Repeating: " + repeating
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

