//
//  leaderBoardModel.swift
//  VisualFit
//
//  Created by iOS on 25/04/24.
//

import Foundation

struct Leaderboard {
    var rank : Int
    var progress_image : String
    var peer_image : String
    var peer_name : String
    var steps : Int
    var calories : Int
    var streak_image : String
}
//
//let leaderBoard_data: [Leaderboard] = [Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),
//                                       Leaderboard(rank: 2, progress_image: "progressUp", peer_image:"mimoji2",peer_name:"harsh",steps:9874,calories: 990, streak_image:"redCross"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "greenCheck"),Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "kunal", steps: 88889, calories: 898, streak_image: "redCross")]
 

let leaderBoard_data: [Leaderboard] = [
    Leaderboard(rank: 1, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "John", steps: 88889, calories: 898, streak_image: "greenCheck"),
    Leaderboard(rank: 2, progress_image: "progressUp", peer_image: "mimoji2", peer_name: "Emma", steps: 9874, calories: 990, streak_image: "redCross"),
    Leaderboard(rank: 3, progress_image: "progressDown", peer_image: "mimoji3", peer_name: "Alice", steps: 98889, calories: 998, streak_image: "greenCheck"),
    Leaderboard(rank: 4, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "Bob", steps: 78889, calories: 798, streak_image: "redCross"),
    Leaderboard(rank: 5, progress_image: "progressDown", peer_image: "mimoji2", peer_name: "Ella", steps: 68889, calories: 898, streak_image: "greenCheck"),
    Leaderboard(rank: 6, progress_image: "progressDown", peer_image: "mimoji3", peer_name: "Mike", steps: 58889, calories: 698, streak_image: "redCross"),
    Leaderboard(rank: 7, progress_image: "progressDown", peer_image: "mimoji1", peer_name: "Sophia", steps: 48889, calories: 598, streak_image: "greenCheck")
]
