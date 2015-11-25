//
//  ViewController.swift
//  CoreMotionPedometer
//
//  Created by Hamilton Dang on 11/15/15.
//  Copyright © 2015 Codon. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var stepLabel: UILabel!
    var stepController: StepController = StepController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepController.updateStepRT()
        stepLabel.text = "\(stepController.dataModel.totalSteps)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}