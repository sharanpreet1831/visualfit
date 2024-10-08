
import Foundation
import UIKit

struct DiscoverPostFeed{
    var postImg : UIImage
    var captionText : String
    var like : Int
    var commentsCount : Int
    var comments : [Comment]
    var userName : String
    var userImgUrl : UIImage
    var label : String
}


class PostsData{
    var posts:[DiscoverPostFeed] = []
    
    private static let instance : PostsData = PostsData()
    
    static func getInstance () -> PostsData{
        return instance
    }
    
    func getPosts() -> [DiscoverPostFeed]{
        return posts
    }
    
    private init() {
        let userNames = [
            "Ashu",
            "Harsh",
            "Neha",
            "Mukesh",
            "Amit",
            "Harsh",
            "Ashu",
            "Neha",
            "Mukesh",
            "Amit",
            "Harsh",
            "Ashu",
            "Neha",
            "Mukesh",
            "Amit",
            "Harsh",
            "Ashu",
            "Neha",
            "Mukesh",
            "Amit"
        ]
        
        let userAvatars = [
            "mimoji6",
            "mimoji1",
            "mimoji2",
            "mimoji4",
            "mimoji5",
            "mimoji1",
            "mimoji6",
            "mimoji2",
            "mimoji4",
            "mimoji5",
            "mimoji1",
            "mimoji6",
            "mimoji2",
            "mimoji4",
            "mimoji5",
            "mimoji1",
            "mimoji3",
            "mimoji2",
            "mimoji4",
            "mimoji5"
        ]
        
        let postImg = [
            "ashuSir",
            "harshPost",
            "nePost",
            "mukeshPost",
            "amitSir",
            "harshPost",
            "ashuSir",
            "nePost",
            "mukeshPost",
            "amitSir",
            "harshPost",
            "ashuSir",
            "nePost",
            "mukeshPost",
            "amitSir",
            "harshPost",
            "ashuSir",
            "nePost",
            "mukeshPost",
            "amitSir"
        ]
        
        var postLabels = [
            "My 90 Days transformation",
            "Hardwork pays well!",
            "Every single calories counts",
            "Let's lift heavy together",
            "Keep it up",
            "My 90 Days transformation",
            "Hardwork pays well!",
            "Every single calories counts",
            "Let's lift heavy together",
            "Keep it up",
            "My 90 Days transformation",
            "Hardwork pays well!",
            "Every single calories counts",
            "Let's lift heavy together",
            "Keep it up",
            "My 90 Days transformation",
            "Hardwork pays well!",
            "Every single calories counts",
            "Let's lift heavy together",
            "Keep it up"
        ]
        
        var fakeData: [DiscoverPostFeed] = []
        
        for i in 0..<15 {
            let postImgURL = URL(string: "https://example.com/post\(i).jpg")!
            let userImgURL = "https://example.com/\(userAvatars[i])"
            let randomIndex = Int.random(in: 0..<userNames.count)
            let post = DiscoverPostFeed(
                postImg: UIImage(named: postImg[i])!,
                captionText: "This is a sample caption for post \(i+1)",
                like: Int.random(in: 0..<100),
                commentsCount: Int.random(in: 0..<20),
                comments: generateRandomComments(),
                userName: userNames[i],
                userImgUrl: UIImage(named:userAvatars[i])!,
                label: postLabels[i]
            )
            fakeData.append(post)
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
        
        posts = fakeData
        
    }
}
