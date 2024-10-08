//
//  LeaderboardViewController.swift
//  VisualFit
//
//  Created by Goyal Harsh on 24/04/24.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    @IBOutlet weak var positionUIView: UIView!
    @IBOutlet weak var leaderBoard_table: UITableView!
    @IBOutlet weak var leaderboardHeaderUIView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionUIView.layer.cornerRadius = 10
        positionUIView.clipsToBounds = true
        leaderBoard_table.dataSource = self
        leaderBoard_table.delegate = self
        // Add rounded corners to top left and top right
        let maskPath = UIBezierPath(roundedRect: leaderboardHeaderUIView.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        leaderboardHeaderUIView.layer.mask = maskLayer
        dateLabel.text = String(Date().formatted(.dateTime.day().weekday().month()))
    }
}
extension LeaderboardViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeaderboardData.getInstance().leadboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellData = leaderBoard_data[indexPath.row]
        let cellData = LeaderboardData.getInstance().leadboard[indexPath.row]   // check this line
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoard_Cell", for: indexPath) as! LeaderBoardTableViewCell
        
        cell.rank_label.text = String(cellData.rank)
        cell.progress_image.image = UIImage(named: cellData.progress_image)
        cell.peer_image.image = UIImage(named: cellData.peer_image)
        cell.steps_label.text = String(cellData.steps)
        cell.calories_label.text = String(cellData.calories)
        cell.streak_image.image = UIImage(named: cellData.streak_image)
        cell.peerName_label.text = cellData.peer_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    }
