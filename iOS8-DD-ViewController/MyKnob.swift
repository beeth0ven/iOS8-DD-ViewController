//
//  MyKnob.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/20/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

//@IBDesignable

class MyKnob: UIControl {
    var angle: CGFloat = 0 {
        didSet {
            angle =  min(5,max(0, angle))
            transform = CGAffineTransformMakeRotation(angle)
        }
    }
    
    var continuous = true
    private var initalAngle: CGFloat = 0
    
    func pointToAngle(touch: UITouch) -> CGFloat {
        let location = touch.locationInView(self)
        let center = CGPointMake(bounds.midX, bounds.midY)
        return atan2(location.y - center.y, location.x - center.x)
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        initalAngle = pointToAngle(touch)
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        let angle = pointToAngle(touch) - self.initalAngle
        self.angle += angle
        if continuous {
            sendActionsForControlEvents(.ValueChanged)
        }
        
        return true
    }
    
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        sendActionsForControlEvents(.ValueChanged)
    }
    
    override func drawRect(rect: CGRect) {
        UIImage(named: "knob")!.drawInRect(rect)
    }
    
}