//
//  UIViewExt.swift
//  VisualFit
//
//  Created by iOS on 05/05/24.
//

// MARK: - code to stick textfield to keyboard

import UIKit
// extension to ui view to bind to the keyboard
extension UIView {
    // function to bind the keyboard
    func bindToKeyboard() {
        // Add observer for keyboard will change frame notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // function called when keyboard will cange frame
    @objc func keyboardWillChange(_ notification: Notification) {
        // Check if notification contains necessary user info
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              let startingFrameValue = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
              let endingFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }
        // Extract animation curve and frames from user info
        let curve = UIView.AnimationOptions(rawValue: curveValue)
        let startingFrame = startingFrameValue.cgRectValue
        let endingFrame = endingFrameValue.cgRectValue
        // Calculate vertical offset due to keyboard movement
        let deltaY = endingFrame.origin.y - startingFrame.origin.y
        // Animate view's frame adjustment with keyboard movement
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.frame.origin.y += deltaY  // Move view vertically
        }, completion: nil)
    }
}
