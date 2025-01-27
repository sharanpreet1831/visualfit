//
//  ProgressViewController.swift
//  VisualFit
//
//  Created by student on 25/04/24.
//

import UIKit

class ProgressViewController: UIViewController {
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var ringBar: PlainCircularProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func progressChanged(_ sender: UISlider) {
        let progress = CGFloat(sender.value)
        ringBar.progress = progress
    }
}

@IBDesignable
class PlainCircularProgressBar: UIView {
    
    
    @IBInspectable var color: UIColor? = .gray {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable var ringWidth: CGFloat = 9

    var progress: CGFloat = 0.8 {
        didSet { setNeedsDisplay() }
    }

    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask

        progressLayer.lineWidth = ringWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }

    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: ringWidth / 2, dy: ringWidth / 2))
        backgroundMask.path = circlePath.cgPath

        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = color?.cgColor
    }
}
