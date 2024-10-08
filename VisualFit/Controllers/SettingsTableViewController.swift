//
//  SettingsTableViewController.swift
//  VisualFit
//
//  Created by student on 30/04/24.
//

import UIKit
import SafariServices

class SettingsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // adding privacy policy
        if(indexPath == IndexPath(row: 0, section: 3)){
            if let url = URL(string: "https://www.termsfeed.com/live/b9f038ef-bea3-4a26-bbe9-f1adce421880"){
                let safariViewController =  SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToWelcome", sender: sender)
    }
    
    @IBAction func unwindToSettings(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
       
    }
}
