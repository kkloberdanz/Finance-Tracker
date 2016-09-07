//
//  calendarViewController.swift
//  Finance Tracker Test
//
//  Created by Zachary Cain on 11/16/15.
//  Copyright © 2015 University of Iowa. All rights reserved.
//

import UIKit
import Charts


class calendarViewController: UIViewController {

    @IBOutlet var barChartView: BarChartView!
    
    
    var months: [String] = []

    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Past Transactions")
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.descriptionText = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lengthOfMyData = Images.init().lengthOfImagesArray()
        
        var unitsSold: [Double] = []
        var currentString = ""
        var currentDate = NSDate()
        
        for i in 0..<lengthOfMyData {
            currentDate = Images.init().dateForIndex(i)
            if ((currentDate.compare(startDate) == NSComparisonResult.OrderedDescending && currentDate.compare(endDate) == NSComparisonResult.OrderedAscending) || (currentDate.compare(startDate) == NSComparisonResult.OrderedSame || currentDate.compare(endDate) == NSComparisonResult.OrderedSame)) {
                unitsSold.append(Images.init().imageAmountForIndex(i))
                if Images.init().imageHeadingForIndex(i).characters.count > 4 {
                    print(Images.init().imageHeadingForIndex(i).characters.count)
                    currentString = Images.init().imageHeadingForIndex(i)
                    let index = currentString.startIndex.advancedBy(4)
                    months.append(Images.init().imageHeadingForIndex(i).substringToIndex(index))
                }
                else {
                    months.append(Images.init().imageHeadingForIndex(i))
                }
            }

            
        }
        
        print (lengthOfMyData)
        print(unitsSold)
        
        setChart(months, values: unitsSold)
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveChart(sender: AnyObject) {
        barChartView.saveToCameraRoll()
    }
    
    
}

