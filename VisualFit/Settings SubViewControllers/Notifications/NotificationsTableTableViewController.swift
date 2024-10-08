//
//  NotificationsTableTableViewController.swift
//  VisualFit
//
//  Created by student on 30/04/24.
//

import UIKit

class NotificationsTableTableViewController: UITableViewController {
    
    //getting instance of the data model for this view controller
    var userNotification = UserNotificationData.getInstance()
    
    @IBOutlet weak var peerActivitySwitch: UISwitch!
    
    @IBOutlet weak var goalCompletionSwitch: UISwitch!
    
    @IBOutlet weak var transformationFeedSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peerActivitySwitch.isOn = userNotification.notificationSelection.isPeerActivityNotificationOn
        goalCompletionSwitch.isOn = userNotification.notificationSelection.isGoalCompletionNotificationOn
        transformationFeedSwitch.isOn = userNotification.notificationSelection.isTransformationFeedNotificationOn
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    //changing text color of footer of table view section
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let footerView = view as? UITableViewHeaderFooterView{
            footerView.textLabel?.textColor = .gray
        }
    }
    //changing text color of header of table view section
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView{
            headerView.textLabel?.textColor = .gray
        }
    }
    
    // on click of done button the function for updating user notification selection is called.
    @IBAction func doneButtonTapped(_ sender: Any) {
        updateUserNotificationSelection()
    }
    
    // updating user notification selection
    func updateUserNotificationSelection(){
        
        userNotification.notificationSelection.isGoalCompletionNotificationOn = goalCompletionSwitch.isOn
        userNotification.notificationSelection.isPeerActivityNotificationOn = peerActivitySwitch.isOn
        userNotification.notificationSelection.isTransformationFeedNotificationOn = transformationFeedSwitch.isOn
        tableView.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateUserNotificationSelection()
    }
}
