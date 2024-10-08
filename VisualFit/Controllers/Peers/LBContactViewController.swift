//
//  LBContactViewController.swift
//  VisualFit
//
//  Created by iOS on 30/04/24.
//

import UIKit

class LBContactViewController: UIViewController {
    
    let lbInstance = LeaderboardData.getInstance()
    
    @IBOutlet weak var ContactsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Sharing"
        // Set the color of the navigation bar title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primary]
        
        ContactsTable.delegate = self
        ContactsTable.dataSource = self
    }
}
// populating contact data
extension LBContactViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ContactData.getInstance().contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = ContactData.getInstance().contacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as! LBContactTableViewCell
        
        cell.peerImage.image = UIImage(named: cellData.peerImage)
        cell.peerName.text = cellData.peerName
        cell.peerContactNumber.text = cellData.peerContact
        return cell
        
    }
    
    // adding new contact in leaderboard
    func addContact(_ contact: ContactModel, peerName: String) {
        // Generate random values for rank, steps, and calories
        let randomRank = Int.random(in: 1...99)
        let randomSteps = Int.random(in: 1000...9999)
        let randomCalories = Int.random(in: 100...500)
        
        // Select random images for progress, peer, and streak
        let progressImages = ["progressUp", "progressDown"]
        let peerImages = ["mimoji1", "mimoji2", "mimoji3"]
        let streakImages = ["greenCheck", "redCross"]
        
        let randomProgressImage = progressImages.randomElement() ?? ""
        let randomPeerImage = peerImages.randomElement() ?? ""
        let randomStreakImage = streakImages.randomElement() ?? ""
        // Create a new Leaderboard instance with the provided data
        let newLeaderboard = Leaderboard(rank: randomRank, progressImage: randomProgressImage, peerImage: randomPeerImage, peerName: peerName, steps: randomSteps, calories: randomCalories, streakImage: randomStreakImage)
        
        // Add the new leaderboard to your data source
        print("before data append\(LeaderboardData.getInstance().leadboard.count)")
        LeaderboardData.getInstance().leadboard.append(newLeaderboard)
        print("after data append\(LeaderboardData.getInstance().leadboard.count)")
        lbInstance.leadboard.sort { $0.steps > $1.steps }
        for (index, leaderboard) in lbInstance.leadboard.enumerated() {
            lbInstance.leadboard[index].rank = index + 1
        }
        print("data is added")
        // Perform any other desired action
        print(LeaderboardData.getInstance().leadboard.count)
        print("Selected Contact Name: \(contact.peerName)")
        print("Selected Contact Number: \(contact.peerContact)")
        
        // Remove the selected contact from ContactData
        // Remove the selected contact from ContactData
        if let index = ContactData.getInstance().contacts.firstIndex(where: { $0.peerName == contact.peerName }) {
            ContactData.getInstance().contacts.remove(at: index)
        }
    }
    // adding the contact to leaderBoard according to name of person selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = ContactData.getInstance().contacts[indexPath.row]
        let selectedPeerName = selectedContact.peerName
        addContact(selectedContact, peerName: selectedPeerName)
        //        print("after that")
    }
}
