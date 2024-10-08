//
//  LeaderBoardViewController.swift
//  VisualFit
//
//  Created by iOS on 30/04/24.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    @IBOutlet weak var positionUIView: UIView!
    @IBOutlet weak var leaderBoardTable: UITableView!
    @IBOutlet weak var leaderboardHeaderUIView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var firstPositionImage: UIImageView!
    @IBOutlet weak var firstPositionName: UILabel!
    @IBOutlet weak var secondPositionImage: UIImageView!
    @IBOutlet weak var secondPositionName: UILabel!
    @IBOutlet weak var thirdPositionImage: UIImageView!
    @IBOutlet weak var thirdPositionName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionUIView.layer.cornerRadius = 10
        positionUIView.clipsToBounds = true
        leaderBoardTable.dataSource = self
        leaderBoardTable.delegate = self
        
        // Add rounded corners to top left and top right
        let maskPath = UIBezierPath(roundedRect: leaderboardHeaderUIView.bounds,
                                    byRoundingCorners: [.allCorners],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        leaderboardHeaderUIView.layer.mask = maskLayer
        //   updating date in the label
        dateLabel.text = String(Date().formatted(.dateTime.day().weekday().month()))
        
        // Create and configure the add button with SF Symbol
        let addButton = UIButton(type: .system)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let symbolImage = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfiguration)
        addButton.setImage(symbolImage, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        addButton.tintColor = .primary
        
        // Auto Layout constraints for the button
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        // add button action
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        // Update top 3 positions
        updateTopThreePositions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leaderBoardTable.reloadData()
        // Update top 3 positions
        updateTopThreePositions()
    }
    // performing segue
    @objc func addButtonTapped() {
        performSegue(withIdentifier: "LBContactSegue", sender: self)
    }
    // updating image of top three positions
    func updateTopThreePositions() {
        let topThreeRanks = LeaderboardData.getInstance().leadboard.prefix(3)
        if let firstRankData = topThreeRanks.first {
            firstPositionImage.image = UIImage(named: firstRankData.peerImage)
            firstPositionName.text = firstRankData.peerName
        }
        if topThreeRanks.count >= 2, let secondRankData = topThreeRanks.dropFirst().first {
            secondPositionImage.image = UIImage(named: secondRankData.peerImage)
            secondPositionName.text = secondRankData.peerName
        }
        if topThreeRanks.count >= 3, let thirdRankData = topThreeRanks.dropFirst(2).first {
            thirdPositionImage.image = UIImage(named: thirdRankData.peerImage)
            thirdPositionName.text = thirdRankData.peerName
        }
    }
}
// populating data in the leaderboard table view
extension LeaderboardViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeaderboardData.getInstance().leadboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = LeaderboardData.getInstance().leadboard[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoard_Cell", for: indexPath) as! LeaderBoardTableViewCell
        
        cell.rankLabel.text = String(cellData.rank)
        cell.progressImage.image = UIImage(named: cellData.progressImage)
        cell.peerImage.image = UIImage(named: cellData.peerImage)
        cell.stepsLabel.text = String(cellData.steps)
        cell.caloriesLabel.text = String(cellData.calories)
        cell.streakImage.image = UIImage(named: cellData.streakImage)
        cell.peerNameLabel.text = cellData.peerName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // exit from the screen contact screen
    @IBAction func unwindToLeaderboard(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.source is LBContactViewController else {
            return
        }
        leaderBoardTable.reloadData()
    }
}
