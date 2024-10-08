//
//  UtilityExtensions.swift
//  VisionDemo
//
//  Created by Harsh Goyal on 09/10/2021.
//

import Vision
import UIKit

extension VNRectangleObservation {
    var points: [CGPoint] {
        return [topLeft, topRight, bottomRight, bottomLeft]
    }
}

extension CVPixelBuffer {
    func makeImage() -> UIImage? {
        let ciImage = CIImage(cvImageBuffer: self)
        
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

extension UIImage {
    
    func draw(openPaths: [[CGPoint]]? = nil,
              closedPaths: [[CGPoint]]? = nil,
              points: [CGPoint]? = nil,
              displayableTexts: [DisplayableText],
              images: [UIImage]?,
              rectangleWorkPoints : [CGPoint],
              fillColor: UIColor = .clear,
              strokeColor: UIColor = .clear,
              radius: CGFloat = 5,
              lineWidth: CGFloat = 2) -> UIImage? {
        let scale: CGFloat = 0
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero)
      
        let imageSize = size
        images?.forEach {
            $0.draw(in: CGRect(origin: .zero, size: imageSize), blendMode: .hue, alpha: 1.0)
        }
        
        points?.forEach { point in
            let path = UIBezierPath(arcCenter: point,
                                    radius: radius,
                                    startAngle: CGFloat(0),
                                    endAngle: CGFloat(Double.pi * 2),
                                    clockwise: true)
            
            fillColor.setFill()
            strokeColor.setStroke()
            path.lineWidth = lineWidth
            
            path.fill()
            path.stroke()
        }

        closedPaths?.forEach { points in
            draw(points: points, isClosed: true, color: strokeColor, lineWidth: lineWidth,rectangleWorkPoints: rectangleWorkPoints)
        }
        
        displayableTexts.forEach { displayableText in
            guard let frame = displayableText.frame else { return }
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
                              NSAttributedString.Key.foregroundColor: fillColor,
                              NSAttributedString.Key.backgroundColor: UIColor.black]
            
            displayableText.text.draw(with: frame,
                                      options: [],
                                      attributes: attributes,
                                      context: nil)
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return newImage
    }
    
    private func draw(points: [CGPoint], isClosed: Bool, color: UIColor, lineWidth: CGFloat,rectangleWorkPoints : [CGPoint]) {
        let bezierPath = UIBezierPath()
        bezierPath.drawLinePath(for: points, isClosed: isClosed)
        color.setStroke()
        bezierPath.lineWidth = lineWidth
        bezierPath.stroke()
        if let context = UIGraphicsGetCurrentContext() {
            UIGraphicsPushContext(context)
            let path = UIBezierPath()
            /// Here we are creating the rectangle points white fill
            path.drawAndFillLinePath(for: rectangleWorkPoints, isClosed: true, fillColor: UIColor.pinkTransform,in: context)
            UIGraphicsPopContext()
        }
        
    }
}

extension UIBezierPath {
    func drawLinePath(for points: [CGPoint], isClosed: Bool) {
        points.enumerated().forEach { [unowned self] iterator in
            let index = iterator.offset
            let point = iterator.element
            
            let isFirst = index == 0
            let isLast = index == points.count - 1
            
            if isFirst {
                move(to: point)
            } else if isLast {
                addLine(to: point)
                move(to: point)
                
                guard isClosed, let firstItem = points.first else { return }
                addLine(to: firstItem)
            } else {
                addLine(to: point)
                move(to: point)
            }
        }
    }
    
    func drawAndFillLinePath(for points: [CGPoint], isClosed: Bool, fillColor: UIColor, in context: CGContext) {
        // Reset the path to clear any previous drawings.
        removeAllPoints()
        
        // Ensure there are enough points to form a shape.
        guard let firstPoint = points.first else { return }
        
        // Start the path.
        move(to: firstPoint)
        
        // Add lines to all the other points.
        for point in points.dropFirst() {
            addLine(to: point)
        }
        
        // Close the path if necessary.
        if isClosed {
            close()
        }
        
        // Set the fill color and fill the path.
        fillColor.setFill()
        fill()
        
        // Optionally, set stroke properties if you want to outline the shape as well.
        UIColor.black.setStroke()  // You can customize the stroke color here.
        lineWidth = 2  // Customize the line width if desired.
        stroke()
        
        // Drawing the coordinates as text near each point.
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.pinkTransform
        ]
        
        points.forEach { point in
            let text = NSString(format: "(%.1f, %.1f)", point.x, point.y)
            let textPoint = CGPoint(x: point.x + 5, y: point.y - 10) // Offset text slightly from point
            text.draw(at: textPoint, withAttributes: attributes)
        }
    }
    
}

extension UIImage {
    func resizeImage(to newSize: CGSize) -> UIImage? {
        let size = self.size
        let widthRatio  = newSize.width  / size.width
        let heightRatio = newSize.height / size.height
        let newSize = widthRatio > heightRatio ? CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        : CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        @unknown default:
            self = .up
        }
    }
}

extension CGPoint {
    func translateFromCoreImageToUIKitCoordinateSpace(using height: CGFloat) -> CGPoint {
        let transform = CGAffineTransform(scaleX: 1, y: -1)
            .translatedBy(x: 0, y: -height);
        
        return self.applying(transform)
    }
    
    func location(in image: UIImage) -> CGPoint {
        VNImagePointForNormalizedPoint(self,
                                       Int(image.size.width),
                                       Int(image.size.height))
    }
}

extension VNRecognizedPoint {
    func location(in image: UIImage) -> CGPoint {
        location.location(in: image)
    }
}

extension CGRect {
    func rectangle(in image: UIImage) -> CGRect {
        VNImageRectForNormalizedRect(self,
                                     Int(image.size.width),
                                     Int(image.size.height))
    }
    
    var points: [CGPoint] {
        return [origin, CGPoint(x: origin.x + width, y: origin.y),
                CGPoint(x: origin.x + width, y: origin.y + height), CGPoint(x: origin.x, y: origin.y + height)]
    }
    
    var area: CGFloat {
        height * width
    }
}
