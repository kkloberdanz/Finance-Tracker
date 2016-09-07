//
//  PieChartTopViewController.swift
//  Finance Tracker Test
//
//  Created by Zachary Cain on 12/12/15.
//  Copyright © 2015 University of Iowa. All rights reserved.
//

import UIKit
import Charts

class PieChartTopViewController: UIViewController {

    @IBOutlet var pieChartView: PieChartView!
    
    
    var months: [String] = []
    
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        pieChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Past Transactions")
        
        let pieChartData = PieChartData(xVals: months, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.descriptionText = "Top 5 Expenses"
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lengthOfMyData = Images.init().lengthOfImagesArray()
        
        var unitsSold: [Double] = []
        var currentString = ""
        var currentDate = NSDate()
        var dictOfItems = [String: Double]()
        
        
        
        for i in 0..<lengthOfMyData {
            currentDate = Images.init().dateForIndex(i)
            if ((currentDate.compare(startDate) == NSComparisonResult.OrderedDescending && currentDate.compare(endDate) == NSComparisonResult.OrderedAscending) || (currentDate.compare(startDate) == NSComparisonResult.OrderedSame || currentDate.compare(endDate) == NSComparisonResult.OrderedSame)) {
                let valueOfItem = Images.init().imageAmountForIndex(i)
                if Images.init().imageHeadingForIndex(i).characters.count > 4 {
                    print(Images.init().imageHeadingForIndex(i).characters.count)
                    currentString = Images.init().imageHeadingForIndex(i)
                    let index = currentString.startIndex.advancedBy(4)
                    let nameOfItem = Images.init().imageHeadingForIndex(i).substringToIndex(index)
                    dictOfItems[nameOfItem] = valueOfItem
                }
                else {
                    let nameOfItem = Images.init().imageHeadingForIndex(i)
                    dictOfItems[nameOfItem] = valueOfItem
                }
            }
            
        }
        
        
        var counter = 0
        for (k,v) in (Array(dictOfItems).sort {$0.1 > $1.1}) {
            if counter >= 5 {
                break
            }
            months.append(k)
            unitsSold.append(v)
            print("\(k):\(v)")
            print("above is values")
            counter = counter + 1
        }
        
        
        print (lengthOfMyData)
        print(unitsSold)
        
        setChart(months, values: unitsSold)
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveChart(sender: AnyObject) {
        pieChartView.saveToCameraRoll()
    }
    
    
}