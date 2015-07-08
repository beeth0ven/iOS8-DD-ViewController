//
//  MyFlowLayout.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/6/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class MyDynamicAnimator: UIDynamicAnimator {
    override init(collectionViewLayout: UICollectionViewLayout) {
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    deinit {
        
    }
}

class MyFlowLayout: UICollectionViewFlowLayout {
    
    var animating = false
    var animator: UIDynamicAnimator!
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        let superLayoutAttributes = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
        let array  = superLayoutAttributes.map {
            attributes -> UICollectionViewLayoutAttributes in
            if attributes.representedElementKind == nil {
                let indexPath = attributes.indexPath
                attributes.frame = self.layoutAttributesForItemAtIndexPath(indexPath).frame
            }
            return attributes
        }
        
        
        if animating {
            var mutableArray = [UICollectionViewLayoutAttributes]()
            for attributes in array {
                let indexPath = attributes.indexPath
                var attributes2: UICollectionViewLayoutAttributes?
                switch attributes.representedElementCategory {
                case .Cell:
                    attributes2 = animator.layoutAttributesForCellAtIndexPath(indexPath)
                case .SupplementaryView:
                    let kind = attributes.representedElementKind
                    attributes2 = animator.layoutAttributesForSupplementaryViewOfKind(kind, atIndexPath: indexPath)
                default: break
                }
                mutableArray += [attributes2 ?? attributes]
            }
            return mutableArray
        }
        return array
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        if indexPath.item == 0 {
            return attributes
        }
        
        if attributes.frame.origin.x - 1 <= sectionInset.left {
            return attributes
        }
        
        let indexPathPrev = NSIndexPath(forItem: indexPath.item-1, inSection: indexPath.section)
        let framePrev = layoutAttributesForItemAtIndexPath(indexPathPrev).frame
        let rightPrev = framePrev.origin.x + framePrev.size.width + minimumInteritemSpacing
        attributes.frame.origin.x = rightPrev
        return attributes
    }
    
    
    
    
    func flush() {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        let visibleWorld = collectionView!.bounds
        animator = MyDynamicAnimator(collectionViewLayout: self)
        
        let attributes = super.layoutAttributesForElementsInRect(visibleWorld)
        animating = true
        
        let items = (attributes as! [UICollectionViewLayoutAttributes]).filter {
            $0.representedElementKind == nil
        }
        let collisionBehavior = UICollisionBehavior(items: items)
        let point1 = CGPointMake(visibleWorld.minX + 80, visibleWorld.maxY)
        let point2 = CGPointMake(visibleWorld.maxX, visibleWorld.maxY)
        collisionBehavior.addBoundaryWithIdentifier("bottom", fromPoint: point1, toPoint: point2)
        collisionBehavior.collisionMode = .Boundaries
        collisionBehavior.collisionDelegate = self
        animator.addBehavior(collisionBehavior)
        
        let dynamicItemBehavior = UIDynamicItemBehavior(items: items)
        dynamicItemBehavior.elasticity = 0.8
        dynamicItemBehavior.friction = 0.1
        animator.addBehavior(dynamicItemBehavior)
        
        let gravityBehavior = UIGravityBehavior(items: items)
        gravityBehavior.magnitude = 0.8
        gravityBehavior.action = {
            let attributes = self.animator.itemsInRect(visibleWorld)
            if  attributes.count == 0 || self.animator.elapsedTime() > 4 {
                delay(0) {
                    self.animator.removeAllBehaviors()
                    self.animator = nil
                }
                delay(0.4) {
                    self.animating = false
                    self.invalidateLayout()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                }
            }
        }
        animator.addBehavior(gravityBehavior)

    }
    
    
}


extension MyFlowLayout: UICollisionBehaviorDelegate {
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        let pushBehavior = UIPushBehavior(items: [item], mode: .Continuous)
        pushBehavior.setAngle(3*CGFloat(M_PI)/4.0, magnitude: 1.5)
        animator.addBehavior(pushBehavior)
        
    }
}