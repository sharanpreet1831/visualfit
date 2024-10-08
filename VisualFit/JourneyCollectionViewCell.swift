//
//  JourneyCollectionViewCell.swift
//  VisualFit
//
//  Created by Goyal Harsh on 23/04/24.
//

import UIKit

class JourneyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var likeUIView: UIView!
    @IBOutlet weak var commentUIView: UIView!
    
    @IBOutlet weak var userImgUIView: UIView!
    
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var likeText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var likeBtnOutlet: UIButton!
    
    var isLiked = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likeUIView.layer.cornerRadius = 10
        likeUIView.clipsToBounds = true
        commentUIView.layer.cornerRadius = 10
        commentUIView.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        userImgUIView.layer.cornerRadius = 25
        userImg.layer.cornerRadius = 25
        userImg.clipsToBounds = true;
        userImgUIView.clipsToBounds = true
    }
    
    @IBAction func handleLike(_ sender: UIButton) {
        // Toggle isLiked
        isLiked = !isLiked
        
        let imageName = isLiked ? "heart.fill" : "heart"
        likeBtnOutlet.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    
}
