//
//  SummaryViewController.swift
//  VisualFit
//
//  Created by student on 24/04/24.
//

import UIKit


let DAY_BOX_RADIUS = CGFloat(7)
let MAIN_BOX_RADIUS = CGFloat(14)

class SummaryViewController: UIViewController {

    @IBOutlet var beforeAfterView: UIView!
    @IBOutlet var beforeImage: UIImageView!
    @IBOutlet var afterImage: UIImageView!
    
    @IBOutlet var dayOne: UIView!
    @IBOutlet var dayTwo: UIView!
    @IBOutlet var dayThree: UIView!
    @IBOutlet var dayFour: UIView!
    @IBOutlet var dayFive: UIView!
    @IBOutlet var daySix: UIView!
    @IBOutlet var daySeven: UIView!
    
    
    @IBOutlet var stepCountBox: UIView!
    @IBOutlet var streakProgressBox: UIView!
    
    @IBOutlet var distanceCoveredBox: UIView!
    
    @IBOutlet var caloriesBurnBox: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        
        beforeAfterView.layer.cornerRadius = 11
        beforeImage.layer.cornerRadius = 14
        afterImage.layer.cornerRadius = 14
        dayOne.layer.cornerRadius = DAY_BOX_RADIUS
        dayTwo.layer.cornerRadius = DAY_BOX_RADIUS
        dayThree.layer.cornerRadius = DAY_BOX_RADIUS
        dayFour.layer.cornerRadius = DAY_BOX_RADIUS
        dayFive.layer.cornerRadius = DAY_BOX_RADIUS
        daySix.layer.cornerRadius = DAY_BOX_RADIUS
        daySeven.layer.cornerRadius = DAY_BOX_RADIUS
        
        stepCountBox.layer.cornerRadius = MAIN_BOX_RADIUS
        streakProgressBox.layer.cornerRadius = MAIN_BOX_RADIUS
        distanceCoveredBox.layer.cornerRadius = MAIN_BOX_RADIUS
        caloriesBurnBox.layer.cornerRadius = MAIN_BOX_RADIUS
        
        
        print("Updated Summary UI")
    }
    
    
    
    @IBAction func unwindToSummary(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    
    
}
