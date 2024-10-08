//
//  ArenaViewController.swift
//  VisualFit
//
//  Created by iOS on 30/04/24.
//

import UIKit

private let reuseIdentifier = "Arena_Cell"

class ArenaCollectionViewController: UICollectionViewController {
    
    
    var thisComments : [Comment] = []
    var indexPath : Int? = nil
    
    // generating layout for the collection view
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(230))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,repeatingSubitem: item,count:1)
        let spacing = CGFloat(20)
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        print("it is triggered")
        collectionView.reloadData()
    }
    
}

// extension for protocol
extension ArenaCollectionViewController: CommentsViewControllerDelegate {
    func commentsViewControllerDismissed() {
        //        print("is is called")
        collectionView.reloadData()
    }
}


// extension to for populating data in collection view
extension ArenaCollectionViewController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return BannerData.getInstance().banners.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArenaCollectionViewCell
        let item = BannerData.getInstance().banners[indexPath.item]
        cell.userName.text = item.peerName
        cell.postTxt.text = item.message
        cell.likes.text = String(item.reactions.count)
        cell.commentsText.text = String(item.comments.count)
        cell.commentsData = item.comments // Assign comments data to cell
        cell.indexPath = indexPath.item
        cell.userImg.image = item.peerImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(BannerData.getInstance().banners[indexPath.item].comments)
        thisComments = BannerData.getInstance().banners[indexPath.item].comments
    }
    
    // This method prepares data to be passed to the CommentsScreenViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CommentsScreenViewController,let cell = sender as? ArenaCollectionViewCell {
            if let comments = cell.commentsData {
                destination.commentsData1 = comments
            }
            if let indexPath = cell.indexPath{
                destination.indexPath = indexPath
            }
            destination.delegate = self // Set the delegate
        }
    }
}
