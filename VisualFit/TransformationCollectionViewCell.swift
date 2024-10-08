//
//  TransformationCollectionViewCell.swift
//  VisualFit
//
//  Created by Goyal Harsh on 23/04/24.
//

import UIKit
import AVFoundation
import AVKit

class TransformationCollectionViewCell: UICollectionViewCell {
    
    var player = AVPlayer()
    var avpController = AVPlayerViewController()
    var url: URL?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startVideo()
    }
    func configure(with videoURL: String) {
        self.url = URL(string: videoURL)
        if let url = url{
            play()
        }
    }
    
    // Here we add AVPlayer in the app
    func startVideo(){
        player = AVPlayer(url: url!)
        avpController.player = player
        player.isMuted = true
        avpController.showsPlaybackControls = false // Hide playback controls
        avpController.view.frame.size.height = self.frame.size.height
        avpController.view.frame.size.width = self.frame.size.width
        self.addSubview(avpController.view)
        player.play()
    }
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
}
