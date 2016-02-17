//
//  ProfileImageView.swift
//
//  Created by Judik Dávid on 2015.03.20.
//  Copyright (c) 2015 All rights reserved.
//

import UIKit

public enum NameOrder {
    case firstNameFirst, lastNameFirst
}

@IBDesignable
public class ProfileImageView: UIView {

    private var imageLayer: CALayer!
    
    @IBInspectable public var lastName: String?
    @IBInspectable public var firstName: String?
    public var nameOrder = NameOrder.firstNameFirst

    public var image: UIImage? {
        didSet { updateLayerProperties() }
    }
    @IBInspectable public var hasOverlay: Bool = false {
        didSet { updateLayerProperties() }
    }
    @IBInspectable public var overlayColor: UIColor = UIColor.whiteColor()
    @IBInspectable public var borderWidth: CGFloat = 0.0
    @IBInspectable public var borderColor: UIColor = UIColor.lightGrayColor()
    private var overlayLayer: CALayer!
    private var borderLayer: CAShapeLayer!
    private var initialLayer = UILabel()
 
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.clearColor()
        
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
        
        let fontSize = self.bounds.height / 2.2
        
        initialLayer.text = self.getInitials(self.firstName, lastName: self.lastName, nameOrder: self.nameOrder)
        initialLayer.textAlignment = .Center
        initialLayer.font = UIFont.systemFontOfSize(fontSize, weight: UIFontWeightLight)
        initialLayer.textColor = UIColor.whiteColor()
        initialLayer.sizeToFit()
        self.initialLayer.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        self.addSubview(initialLayer)
        
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        if imageLayer != nil {
            if let i = image {
                initialLayer.hidden = true
                imageLayer.contents = i.CGImage
            }
            else {
                initialLayer.hidden = false
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
    
    func getInitials(firstName: String?, lastName: String?, nameOrder: NameOrder) -> String? {
        if let fn = firstName, ln = lastName {
            switch nameOrder {
                case .firstNameFirst:
                    return String(fn[fn.startIndex]) + String(ln[ln.startIndex])
                case .lastNameFirst:
                    return String(ln[fn.startIndex]) + String(fn[ln.startIndex])
            }
        }
        else {
            return nil
        }
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        let dirsAny: AnyObject? = NSProcessInfo.processInfo().environment["IB_PROJECT_SOURCE_DIRECTORIES"]
        if let dirsString = dirsAny as? String {
            let projectPaths =  dirsString.componentsSeparatedByString(",")
            if projectPaths.count > 0 {
                //let imagePath = projectPaths[0].stringByAppendingPathComponent("TestImages/dad.jpg")
                //image = UIImage(contentsOfFile: imagePath)
            }
        }
        
    }
    
}

