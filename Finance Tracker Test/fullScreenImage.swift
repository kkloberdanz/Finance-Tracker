//
//  fullScreenImage.swift
//  Finance Tracker Test
//
//  Created by Mengyao Liu on 12/9/15.
//  Copyright © 2015 University of Iowa. All rights reserved.
//

import Foundation

import UIKit

class fullScreenImage: UIViewController{

    @IBOutlet weak var fullScreenImage: UIImageView!
    var imageName:UIImage = UIImage(named: "no_image.jpg")!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenImage.image = imageName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
