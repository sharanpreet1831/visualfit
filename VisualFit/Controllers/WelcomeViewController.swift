//
//  WelcomeViewController.swift
//  VisualFit
//
//  Created by Goyal Harsh on 26/04/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func unwindToWelcomeScreen(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
    }
    

}
