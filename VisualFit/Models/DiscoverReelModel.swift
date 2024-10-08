//
//  DiscoverReelModel.swift
//  VisualFit
//
//  Created by Goyal Harsh on 24/04/24.
//
import Foundation

struct DisoverReelModel {
    var videoUrl: String
    var like: Int
    var commentsCount: Int
    var comments: [Comment]
    var userName: String
    var userImgUrl: String
}

class ReelsData {
    var reels: [DisoverReelModel] = []
    
    private static let instance: ReelsData = ReelsData()
    
    static func getInstance() -> ReelsData {
        return instance
    }
    
    func getReels() -> [DisoverReelModel] {
        return reels
    }
    
    private init() {
        let userNames = ["John", "Emily", "Michael", "Sophia", "William", "Olivia", "James", "Emma", "Alexander", "Charlotte", "Daniel", "Ava", "Matthew", "Isabella", "Andrew"]
        
        let userAvatars = ["avatar1.jpg", "avatar2.jpg", "avatar3.jpg", "avatar4.jpg", "avatar5.jpg", "avatar6.jpg", "avatar7.jpg", "avatar8.jpg", "avatar9.jpg", "avatar10.jpg", "avatar11.jpg", "avatar12.jpg", "avatar13.jpg", "avatar14.jpg", "avatar15.jpg"]
        
        var fakeData: [DisoverReelModel] = []
        
        for i in 0..<10 {
            let videoURL = "https://example.com/video\(i).mp4"
            let randomIndex = Int.random(in: 0..<userNames.count)
            let reel = DisoverReelModel(
                videoUrl: videoURL,
                like: Int.random(in: 0..<100),
                commentsCount: Int.random(in: 0..<20),
                comments: generateRandomComments(),
                userName: userNames[randomIndex],
                userImgUrl: "https://example.com/\(userAvatars[randomIndex])"
            )
            fakeData.append(reel)
        }
        
        func generateRandomComments() -> [Comment] {
            var comments: [Comment] = []
            let commentCount = Int.random(in: 0..<5)
            for _ in 0..<commentCount {
                let randomIndex = Int.random(in: 0..<userNames.count)
                let comment = Comment(
                    userName: userNames[randomIndex],
                    userAvatar: "https://example.com/\(userAvatars[randomIndex])",
                    date: Date(),
                    comment: "This is a random comment."
                )
                comments.append(comment)
            }
            return comments
        }
        
        reels = fakeData
    }
}
