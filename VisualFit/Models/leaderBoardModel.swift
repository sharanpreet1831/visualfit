//
//  leaderBoardModel.swift
//  VisualFit
//
//  Created by iOS on 25/04/24.
//

import Foundation

struct Leaderboard {
    var rank : Int
    var progressImage : String
    var peerImage : String
    var peerName : String
    var steps : Int
    var calories : Int
    var streakImage : String
}
// creating a sigleton instance
class LeaderboardData {
    var leadboard : [Leaderboard] = []
    private static let instance : LeaderboardData = LeaderboardData()
    
    static func getInstance() -> LeaderboardData{
        return instance
    }
    
    func getBannersData() -> [Leaderboard]{
        return leadboard
    }
    
    private init() {
        var leaderBoardData: [Leaderboard] = [
            Leaderboard(
                rank: 1,
                progressImage: "progressUp",
                peerImage: "mimoji1",
                peerName: "Harsh",
                steps: 9999,
                calories: 898,
                streakImage: "greenCheck"
            ),
            Leaderboard(
                rank: 2,
                progressImage: "progressUp",
                peerImage: "mimoji2",
                peerName: "Riti",
                steps: 6874,
                calories: 990,
                streakImage: "redCross"
            ),
            Leaderboard(
                rank: 3,
                progressImage: "progressDown",
                peerImage: "mimoji6",
                peerName: "Ashu",
                steps: 7889,
                calories: 998,
                streakImage: "greenCheck"
            ),
            Leaderboard(
                rank: 4,
                progressImage: "progressDown",
                peerImage: "mimoji4",
                peerName: "Kunal",
                steps: 9970,
                calories: 798,
                streakImage: "redCross"
            ),
            Leaderboard(
                rank: 5,
                progressImage: "progressUp",
                peerImage: "mimoji7",
                peerName: "Mahak",
                steps: 8889,
                calories: 898,
                streakImage: "greenCheck"
            ),
            Leaderboard(
                rank: 6,
                progressImage: "progressDown",
                peerImage: "mimoji5",
                peerName: "Lakshay",
                steps: 8689,
                calories: 698,
                streakImage: "redCross"
            ),
            Leaderboard(
                rank: 7,
                progressImage: "progressUp",
                peerImage: "mimoji6",
                peerName: "Livanshu",
                steps: 4889,
                calories: 598,
                streakImage: "greenCheck"
            )
        ]
        // sorting the leaderBoard data in descending order
        leaderBoardData.sort { $0.steps > $1.steps }
        for (index, _) in leaderBoardData.enumerated() {
            leaderBoardData[index].rank = index + 1
        }
        leadboard = leaderBoardData
    }
    
}
