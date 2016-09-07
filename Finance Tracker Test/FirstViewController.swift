//
//  FirstViewController.swift
//  Finance Tracker Test
//
//  Created by Kyle Kloberdanz on 7/11/15.
//  Copyright © 2015 University of Iowa. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIAlertViewDelegate{

    var storedBalance = "0.0"
    
    @IBOutlet weak var balanceAmount: UILabel!
	// when pressed, segues to edit view controller
   
    @IBOutlet weak var theBalanceAmount: UILabel!

	
	@IBOutlet weak var theTableView: UITableView!

	@IBOutlet weak var cell: UIView!
	
	var CategoriesArray: [String] = []
    var refreshControl = UIRefreshControl()
    
    func configurationTextFieldForIncome(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = selectedCellCategory
        alertText = textField
        alertText.keyboardType = UIKeyboardType.NumbersAndPunctuation
    }
    
    @IBAction func addIncomePressed(sender: UIButton) {
        
        let alert:UIAlertController = UIAlertController(title: "Add Income", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(self.configurationTextFieldForIncome)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:self.handleCancel))
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            self.theTableView.reloadData()
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //let newuser: newUser = segue.destinationViewController as! newUser
            let dataInput:dataInputViewController = segue.destinationViewController as! dataInputViewController
        
            let categoryIndex:Int = theTableView.indexPathForSelectedRow!.row
            let categoryName:String = CategoriesArray[categoryIndex]
            dataInput.category = categoryName
    }
    

	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return CategoriesArray.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = self.theTableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        let cellColor1 = UIColor(red: (203/255.0), green: (239/255.0), blue: (247/255.0), alpha: 1)
        let cellColor2 = UIColor(red: (128/255.0), green: (195/255.0), blue: (211/255.0), alpha: 1)
        let gradient: [CGColorRef] = [cellColor1.CGColor,cellColor2.CGColor]
        let gradientLocation: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient
        gradientLayer.locations = gradientLocation
        
        if CategoriesArray.count % 2 == 0{
            if indexPath.row % 2 == 0{
                cell.backgroundColor = cellColor1
            }else{
                cell.backgroundColor = cellColor2
            }
            
        }else{
            if indexPath.row % 2 != 0{
                cell.backgroundColor = cellColor1
            }else{
                cell.backgroundColor = cellColor2
            }
            
        }
        
        cell.textLabel?.text = CategoriesArray[indexPath.row]

		return cell
	}
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    var selectedCellCategory = ""
    
    func configurationTextFieldForRename(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = selectedCellCategory
        alertText = textField
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editCategory = UITableViewRowAction(style: .Normal, title: "Rename") { (UITableViewRowAction: UITableViewRowAction!, NSIndexPath:NSIndexPath!) -> Void in
            self.selectedCellCategory = self.CategoriesArray[indexPath.row]
            let alert:UIAlertController = UIAlertController(title: "Creat a Category", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addTextFieldWithConfigurationHandler(self.configurationTextFieldForRename)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:self.handleCancel))
            alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
                print("Done !!")
                print("Item : " + self.alertText.text!)
                self.CategoriesArray[indexPath.row] = self.alertText.text!
                self.theTableView.reloadData()
            }))
            self.presentViewController(alert, animated: true, completion: {
                print("completion block")
            })
            

        }
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { (UITableViewRowAction: UITableViewRowAction!, NSIndexPath:NSIndexPath!) -> Void in
            self.CategoriesArray.removeAtIndex(indexPath.row)
            self.theTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation .Left)
            self.theTableView.reloadData()
        }
        
        
        editCategory.backgroundColor = UIColor.blueColor()
        delete.backgroundColor = UIColor.redColor()
        return [delete, editCategory]
    }

    
    var alertText: UITextField!
    
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = "Enter your Category Name"
        alertText = textField
    }
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("Cancelled !!")
    }
    
	@IBAction func addCellWasPressed(sender: UIButton) {
        
        // pop up an alert box with text field to enter category name
        let alert:UIAlertController = UIAlertController(title: "Creat a Category", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            print("Done !!")
            print("Item : " + self.alertText.text!)
            
            self.CategoriesArray.insert(self.alertText.text!, atIndex: 0)
            self.theTableView.rowHeight = UITableViewAutomaticDimension
            self.theTableView.estimatedRowHeight = 44.0
            self.theTableView.reloadData()
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
        
        print("Add Cell Button Pressed", terminator: "")
        
	}
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        print("viewWill aPPere---------------------")
        
        print(userDefaults.stringForKey("storedBalance"))
        if userDefaults.stringForKey("storedBalance") != nil {
            storedBalance = userDefaults.stringForKey("storedBalance")!
            theBalanceAmount.text = "$\(storedBalance)"
        }
        theBalanceAmount.text = "$\(storedBalance)"
        if isFirstTimeOpening() {
            
        } else {
            if isStartUp {
                let userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                CategoriesArray = userDef.arrayForKey("cells") as! [String]
                restoreDataArray()
            } else {
                
            }
            
        }
        self.theTableView.reloadData()
        print("\(isFirstTimeOpening())")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        isStartUp = false
        NSUserDefaults.standardUserDefaults().setObject(CategoriesArray, forKey: "cells")
        print("\(isFirstTimeOpening())")
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
        refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        self.theTableView.addSubview(refreshControl)
		// Do any additional setup after loading the view, typically from a nib.
		
		// repopulate with cells from before
        
        
	}
    
    func refresh() {
        // pop up an alert box with text field to enter category name
        let alert:UIAlertController = UIAlertController(title: "Creat a Category", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            print("Done !!")
            print("Item : " + self.alertText.text!)
            
            print("pull down to add new", terminator: "")
            self.CategoriesArray.insert(self.alertText.text!, atIndex: 0)
            self.theTableView.rowHeight = UITableViewAutomaticDimension
            self.theTableView.estimatedRowHeight = 44.0
            self.theTableView.reloadData()
            self.refreshControl.endRefreshing()
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
    
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    

}

