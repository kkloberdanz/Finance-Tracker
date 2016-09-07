//
//  receiptsCollectionViewController.swift
//  Recent Tab
//
//  Created by Mengyao Liu on 11/3/15.
//  Copyright © 2015 Mengyao Liu. All rights reserved.
//

import UIKit

class receiptsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    
    var images:Images = Images()
    var detailVC:ViewController = ViewController()
    var refresher: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var theCollectionView: UICollectionView!

        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let userInformation:ViewController = segue.destinationViewController as! ViewController
        let userIndex:Int = theCollectionView.indexPathsForSelectedItems()![0].row
        let imageName:UIImage = images.imageNameForIndex(userIndex)
        let heading:String = images.imageHeadingForIndex(userIndex)
        let amount: Double = images.imageAmountForIndex(userIndex)
        let location: String = images.imageLocationForIndex(userIndex)
        let description: String = images.imageDescriptionForIndex(userIndex)
        let category:String = images.categoryForIndex(userIndex)
        let repeating:String = images.repeatingForIndex(userIndex)
        let dateString:String = images.dateStringForIndex(userIndex)
        userInformation.imageName = imageName
        userInformation.heading = heading
        userInformation.amount = amount
        userInformation.location = location
        userInformation.descriptions = description
        userInformation.categoryName = category
        userInformation.indexRow = userIndex
        userInformation.repeating = repeating
        userInformation.dateString = dateString
        
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return images.numberOfImages()
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellNum:Int = indexPath.row
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! receiptsCollectionViewCell
        
        let cellColor1 = UIColor(red: (238/255.0), green: (238/255.0), blue: (238/255.0), alpha: 1)
        let cellColor2 = UIColor(red: (138/255.0), green: (161/255.0), blue: (166/255.0), alpha: 1)
        let gradient: [CGColorRef] = [cellColor1.CGColor,cellColor2.CGColor]
        let gradientLocation: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient
        gradientLayer.locations = gradientLocation
        
        gradientLayer.frame = cell.bounds
        cell.layer.insertSublayer(gradientLayer, atIndex: 0)
        cell.imageCell.image = images.imageNameForIndex(cellNum)
        cell.headingCell.text = images.imageHeadingForIndex(cellNum)
        cell.amountCell.text = "$\(images.imageAmountForIndex(cellNum))"
        let date = images.dateForIndex(cellNum)
        let calendar = NSCalendar.currentCalendar().components([.Year, .Month, .Day, .Hour, .Minute], fromDate: date)
        let year = calendar.year
        let month = calendar.month
        let day = calendar.day
        let hour = calendar.hour
        let minute = calendar.minute
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString:String = dateFormatter.stringFromDate(NSDate())
        
        if dateString == "\(year)-\(month)-\(day)" {
            cell.dateCell.text = "\(hour):\(minute)"
        }else {
            cell.dateCell.text = "\(month)/\(day)/\(year)"
        }
        // Configure the cell
    
        return cell
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.theCollectionView.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
