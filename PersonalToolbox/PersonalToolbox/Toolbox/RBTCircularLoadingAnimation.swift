//
//  RBTCircularLoadingAnimation.swift
//  CircularAnimations
//
//  Created by Romain Bousquet on 30/10/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

import Foundation
import UIKit

let completeCircle: Double = M_PI * 2
let startCircle: Double    = M_PI + (M_PI/2)
let lineWidth: CGFloat     = 5
let radiusCircle: Int      = 15

class RBTCircularLoadingAnimation: UIView {
    
    var progress: Float {
        didSet(newProgress) {
            self.setProgress(newProgress)
        }
    }
    private var progressToGo: Float
    private var animationInProgress: Bool
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.progress            = 0
        self.progressToGo        = 0
        self.animationInProgress = false
        super.init(frame: frame)
        self.backgroundColor = UIColor.grayWithRGB(216)
    }
    
    // MARK: - Drawing circle
    func setAnimationDone() {
        self.animationInProgress = false
        if (self.progressToGo > self.progress) {
            self.setProgress(self.progressToGo)
        }
    }
    
    func setProgress(newProgress: Float) {
        var tmpProgress: Float = newProgress
        if (tmpProgress <= self.progress) {
            return
        } else if (tmpProgress > 1) {
            tmpProgress = 1.0
        }
        if (self.animationInProgress) {
            self.progressToGo = tmpProgress
            return
        }
        self.animationInProgress = true
        var animationTime: Float = tmpProgress - self.progress
        var timer = NSTimer.scheduledTimerWithTimeInterval(Double(animationTime), target: self, selector: Selector("setAnimationDone"), userInfo: nil, repeats: false)
        var startAngle: Float = Float(completeCircle) * self.progress - Float(M_PI_2)
        var endAngle: Float   = Float(completeCircle) * tmpProgress - Float(M_PI_2)
        var circle: CAShapeLayer = CAShapeLayer()
        circle.path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)), radius: CGFloat(radiusCircle), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true).CGPath
        circle.fillColor   = UIColor.clearColor().CGColor
        circle.strokeColor = UIColor.whiteColor().CGColor
        circle.lineWidth   = lineWidth
        self.layer.addSublayer(circle)
        
        var drawAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration            = Double(animationTime)
        drawAnimation.repeatCount         = 0
        drawAnimation.removedOnCompletion = false
        drawAnimation.fromValue = 0
        drawAnimation.toValue   = 1
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        circle.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        self.progress = tmpProgress
    }
}