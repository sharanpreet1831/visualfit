//
//  ProfileViewController.swift
//  VisualFit
//
//  Created by student on 19/04/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    //    @IBOutlet weak var currentStreakCountLabel: UILabel!
    
    @IBOutlet weak var friendsCount: UILabel!
    
    @IBOutlet weak var bestStreakCountLabel: UILabel!
    
    @IBOutlet weak var achivementsUIView: UIView!
    
    
    @IBOutlet weak var badgesStackView: UIStackView!
    
    var userInstance = UserData.getInstance();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        achivementsUIView.layer.cornerRadius = 10
        fullNameLabel.text = userInstance.user.fullName
        usernameLabel.text = userInstance.user.username
        bestStreakCountLabel.text = "\(userInstance.user.bestStreak)"
        friendsCount.text = "\(userInstance.user.friendsCount)"
    }
    
    @IBAction func unwindToProfile(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
    }
    
}
