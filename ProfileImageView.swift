//
//  ProfileImageView.swift
//
//  Created by Judik Dávid on 2015.03.20.
//  Copyright (c) 2015 All rights reserved.
//

import UIKit

@IBDesignable
class ProfileImageView: UIView {

    var imageLayer: CALayer!
    var image: UIImage? {
        didSet { updateLayerProperties() }
    }
    @IBInspectable var hasOverlay: Bool = false {
        didSet { updateLayerProperties() }
    }
    @IBInspectable var overlayColor: UIColor = UIColor.whiteColor()
    @IBInspectable var borderWidth: CGFloat = 2.0
    @IBInspectable var borderColor: UIColor = UIColor.lightGrayColor()
    var overlayLayer: CALayer!
    var borderLayer: CAShapeLayer!
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if borderLayer == nil {
            borderLayer = CAShapeLayer()
            layer.addSublayer(borderLayer)
            
            let rect = CGRectInset(bounds, borderWidth / 2.0, borderWidth / 2.0)
            let path = UIBezierPath(ovalInRect: rect)
            
            borderLayer.path = path.CGPath
            borderLayer.fillColor = nil
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.CGColor
        }
        borderLayer.frame = layer.bounds
        
        if imageLayer == nil {
            let imageMaskLayer = CAShapeLayer()
            
            let rect = CGRectInset(bounds, borderWidth, borderWidth)
            let innerPath = UIBezierPath(ovalInRect: rect)
            
            imageMaskLayer.path = innerPath.CGPath
            imageMaskLayer.fillColor = UIColor.blackColor().CGColor
            imageMaskLayer.frame = bounds
            layer.addSublayer(imageMaskLayer)
            
            imageLayer = CALayer()
            imageLayer.mask = imageMaskLayer
            imageLayer.frame = bounds
            imageLayer.backgroundColor = UIColor.lightGrayColor().CGColor
            imageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(imageLayer)
        }
        
        if overlayLayer == nil {
            let imageMaskLayer = CAShapeLayer()
            
            let innerPath = UIBezierPath(ovalInRect: bounds)
            
            imageMaskLayer.path = innerPath.CGPath
            imageMaskLayer.fillColor = UIColor.blackColor().CGColor
            imageMaskLayer.frame = bounds
            layer.addSublayer(imageMaskLayer)
            
            overlayLayer = CALayer()
            overlayLayer.mask = imageMaskLayer
            overlayLayer.frame = bounds
            overlayLayer.backgroundColor = overlayColor.CGColor
            overlayLayer.opacity = 0.5
            layer.addSublayer(overlayLayer)
        }
        
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        if imageLayer != nil {
            if let i = image {
                imageLayer.contents = i.CGImage
            }
        }
        
        if overlayLayer != nil {
            if hasOverlay {
                overlayLayer.hidden = false
            }
            else {
                overlayLayer.hidden = true
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        let dirsAny: AnyObject? = NSProcessInfo.processInfo().environment["IB_PROJECT_SOURCE_DIRECTORIES"]
        if let dirsString = dirsAny as? String {
            let projectPaths =  dirsString.componentsSeparatedByString(",")
            if projectPaths.count > 0 {
                let imagePath = projectPaths[0].stringByAppendingPathComponent("TestImages/dad.jpg")
                println(imagePath)
                image = UIImage(contentsOfFile: imagePath)
            }
        }
        
    }
}
