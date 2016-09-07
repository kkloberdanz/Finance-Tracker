//
//  actualCalendarViewController.swift
//  Finance Tracker Test
//
//  Created by Zachary Cain on 11/16/15.
//  Copyright © 2015 University of Iowa. All rights reserved.
//

import UIKit


class actualCalendarViewController: UIViewController {


    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var makeChartButton: UIButton!
    
    
    
    @IBAction func startDatePickerChanged(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let strDate = dateFormatter.stringFromDate(startDatePicker.date)
        let mydate = dateFormatter.dateFromString(strDate)
        startDate = startDatePicker.date
        endDate = endDatePicker.date
        
        startDateLabel.text = "Start Date: " + strDate
        
        print(startDate)
        print(mydate)
    }
    
    @IBAction func endDatePickerChanged(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let enDate = dateFormatter.stringFromDate(endDatePicker.date)
        let mydate = dateFormatter.dateFromString(enDate)
        endDate = endDatePicker.date
        startDate = startDatePicker.date
        
        endDateLabel.text = "End Date: " + enDate

        print(endDate)
        print(mydate)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDatePicker.datePickerMode = UIDatePickerMode.Date
        endDatePicker.datePickerMode = UIDatePickerMode.Date
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let strDate = dateFormatter.stringFromDate(startDatePicker.date)
        startDateLabel.text = "Start Date: " + strDate

        let enDate = dateFormatter.stringFromDate(endDatePicker.date)
        endDateLabel.text = "End Date: " + enDate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
