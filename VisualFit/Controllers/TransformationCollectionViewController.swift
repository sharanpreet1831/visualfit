//
//  TransformationCollectionViewController.swift
//  VisualFit
//
//  Created by Goyal Harsh on 23/04/24.
//

import UIKit

private let reuseIdentifier = "Transform_Cell"

class TransformationCollectionViewController: UICollectionViewController {
    
    let items : [String] = [
        "https://res.cloudinary.com/drgzprwnz/video/upload/v1714976942/transformation_1_zhtiwm.mp4","https://res.cloudinary.com/drgzprwnz/video/upload/v1714977544/transformation_2_zailg6.mp4","https://res.cloudinary.com/drgzprwnz/video/upload/v1714978577/transformation_3_akan6k.mp4",
        "https://res.cloudinary.com/drgzprwnz/video/upload/v1714978604/transformation_4_zzquag.mp4",
        "https://res.cloudinary.com/drgzprwnz/video/upload/v1714976942/transformation_1_zhtiwm.mp4",
        "https://res.cloudinary.com/drgzprwnz/video/upload/v1714977544/transformation_2_zailg6.mp4",
        "https://cdn.pixabay.com/video/2023/01/25/147898-792811387_tiny.mp4",
        "https://cdn.pixabay.com/video/2022/07/24/125314-733046618_tiny.mp4",
        "https://cdn.pixabay.com/video/2022/10/07/133925-758328055_tiny.mp4",
        "https://cdn.pixabay.com/video/2023/03/15/154787-808530571_large.mp4",
        "https://cdn.pixabay.com/video/2023/03/15/154787-808530571_large.mp4",
        "https://cdn.pixabay.com/video/2023/03/15/154787-808530571_large.mp4"
    ]
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.88))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,repeatingSubitem: item,count:1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restorationIdentifier = "TransformationViewController"
        self.view.backgroundColor = .green
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        collectionView.isPagingEnabled = true
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TransformationCollectionViewCell
        cell.configure(with:items[indexPath.item])
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        handleVisibleCell()
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            handleVisibleCell()
        }
    }
    
    func handleVisibleCell() {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? TransformationCollectionViewCell {
                cell.play()
            }
        }
        pauseInvisibleCells(except: visibleIndexPaths)
    }
    
    func pauseInvisibleCells(except visibleIndexPaths: [IndexPath]) {
        let allIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in allIndexPaths {
            if !visibleIndexPaths.contains(indexPath) {
                if let cell = collectionView.cellForItem(at: indexPath) as? TransformationCollectionViewCell {
                    cell.pause()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? TransformationCollectionViewCell {
            cell.play()
        }
        print("cell will display \(indexPath.item)")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? TransformationCollectionViewCell {
            cell.pause()
        }
        print("cell will end display \(indexPath.item)")
    }
}


