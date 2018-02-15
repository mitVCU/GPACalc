//
//  ViewController.swift
//  GPACalc
//
//  Created by Mit Amin on 2/13/18.
//  Copyright © 2018 Mit Amin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var courseName: UITextField!
    
    
    @IBOutlet weak var credits:
    UITextField!
    
    /////////assignment input//////////
    @IBOutlet weak var assignmentPoint: UITextField!
    
    @IBOutlet weak var assignmentMax: UITextField!
    
    @IBOutlet weak var assignmentPercent: UITextField!
    //////////////////////////////
    /////////Midterm input////////
    
    @IBOutlet weak var midtermPoint: UITextField!
    
    @IBOutlet weak var midtermMax: UITextField!
    
    @IBOutlet weak var midtermPercent: UITextField!
    /////////////////////////////////
    /////Final input/////////////////
    @IBOutlet weak var finalPoint: UITextField!
    
    @IBOutlet weak var finalMax: UITextField!
    
    @IBOutlet weak var finalPercent: UITextField!
    /////////////////////////////////
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

