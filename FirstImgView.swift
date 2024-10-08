//
//  FirstImgView.swift
//  VisualFit
//
//  Created by Goyal Harsh on 30/04/24.
//

import UIKit

class FirstImgView: UIView {

    var isSelected = true
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 75
        self.clipsToBounds = true
        self.backgroundColor = .primary
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGesture()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    func updateBackgroundColor(color : UIColor,isSelected:Bool){
        self.backgroundColor = color
        self.isSelected = isSelected
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        // Notify the delegate or send a notification to the view controller
        NotificationCenter.default.post(name: Notification.Name("FirstImgViewTapped"), object: self)
    }
    
}
