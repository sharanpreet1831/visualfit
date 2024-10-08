//
//  ArenaModels.swift
//  VisualFit
//
//  Created by iOS on 26/04/24.
//

import Foundation
import UIKit
struct BannerModel {
    var peerImage : UIImage
    var peerName : String
    var peerId : String
    var message : String
    var reactions : [String]
    var comments : [Comment]
}

// creating a singleton instance
class BannerData{
    var banners : [BannerModel] = []
    private static let instance : BannerData = BannerData()
    
    static func getInstance() -> BannerData{
        return instance
    }
    
    func getBannersData() -> [BannerModel]{
        return banners
    }
    
    private init(){
        let data = [
            BannerModel(
                peerImage: UIImage(
                    named: "mimoji1"
                )!,
                peerName: "Harsh",
                peerId: "1",
                message: "Completed this week's fitness streak",
                reactions: [
                    "like",
                    "love",
                    "text"
                ],
                comments: [
                    Comment(
                        userName: "Karma",
                        userAvatar: "mimoji2",
                        date: Date(),
                        comment: "hello u doing great "
                    ),
                    Comment(
                        userName: "Bharat",
                        userAvatar: "mimoji1",
                        date: Date(),
                        comment: "Great work man"
                    )
                ]
            ),
            BannerModel(
                peerImage: UIImage(
                    named: "mimoji6"
                )!,
                peerName: "Ashu",
                peerId: "2",
                message: "Achieved a new personal record in step count",
                reactions: [
                    "like",
                    "wow"
                ],
                comments: [
                    Comment(
                        userName: "ramu",
                        userAvatar: "mimoji2",
                        date: Date(),
                        comment: "hello u doing great "
                    ),
                    Comment(
                        userName: "ju bhai ",
                        userAvatar: "mimoji1",
                        date: Date(),
                        comment: "kya haal hai bhai 2"
                    )
                ]
            ),
            BannerModel(
                peerImage: UIImage(
                    named: "mimoji4"
                )!,
                peerName: "Kunal",
                peerId: "3",
                message: "Surpassed their fitness goal for the week",
                reactions: [
                    "like",
                    "angry",
                    "like",
                    "wow"
                ],
                comments: []
            ),
            BannerModel(
                peerImage: UIImage(
                    named: "mimoji2"
                )!,
                peerName: "Riti",
                peerId: "4",
                message: "completed a challenging workout",
                reactions: ["like"],
                comments: []
            ),
            BannerModel(
                peerImage: UIImage(
                    named: "mimoji5"
                )!,
                peerName: "Harashish",
                peerId: "5",
                message: "Is staying active and healthy",
                reactions: [
                    "like",
                    "sad"
                ],
                comments: []
            ),
        ]
        
        banners = data
        
    }
    
}
