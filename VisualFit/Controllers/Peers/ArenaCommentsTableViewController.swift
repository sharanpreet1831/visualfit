//
//  ArenaCommentsTableViewController.swift
//  VisualFit
//
//  Created by iOS on 03/05/24.
//

import UIKit

class ArenaCommentsTableViewController: UITableViewController {
    
    var comments2:[Comment] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("what is this => \(comments2.count)")
        return comments2.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData = comments2[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArenaCommentsCell", for: indexPath) as! ArenaCommentsTableViewCell
        cell.userAvatar.image = UIImage(named: cellData.userAvatar)
        cell.userNameLabel.text = cellData.userName
        cell.commentLabel.text = cellData.comment
        return cell
    }
    
}
