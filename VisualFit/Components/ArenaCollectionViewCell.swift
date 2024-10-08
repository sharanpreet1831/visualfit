//
//  ArenaCollectionViewCell.swift
//  VisualFit
//
//  Created by Goyal Harsh on 24/04/24.
//

import UIKit

class ArenaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImgUIView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postTxt: UILabel!
    @IBOutlet weak var likeUIView: UIView!
    @IBOutlet weak var commentUIView: UIView!
    var commentsData: [Comment]?
    var indexPath : Int? = nil
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var commentsText: UILabel!
    
    // settin up corner radius of elements
    override func layoutSubviews() {
        userImgUIView.layer.cornerRadius = 20
        userImg.layer.cornerRadius = 20
        self.layer.cornerRadius = 16
        likeUIView.layer.cornerRadius = 10
        commentUIView.layer.cornerRadius = 10
        
        userImgUIView.clipsToBounds = true
        userImg.clipsToBounds = true
        self.clipsToBounds = true
        likeUIView.clipsToBounds = true
        commentUIView.clipsToBounds = true
    }
    
    
    
}
