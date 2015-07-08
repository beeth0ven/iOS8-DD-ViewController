//
//  CustomTabBarControllerAnimatedTransitioning.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 6/19/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class TabBarPushAnimation: NSObject, UIViewControllerAnimatedTransitioning{
    
    var tabBarController: UITabBarController?
    
    private struct Constants {
        static let transitionDuration = 0.4
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return Constants.transitionDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if tabBarController != nil {
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            
            let containerView = transitionContext.containerView()
            
            let fromViewStartFrame = transitionContext.initialFrameForViewController(fromVC)
            let toViewEndFrame = transitionContext.finalFrameForViewController(toVC)
            
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            let fromVCIndex = find(tabBarController!.viewControllers as! [UIViewController], fromVC)
            let toVCIndex =  find(tabBarController!.viewControllers as! [UIViewController], toVC)
            
            // Get the move direction
            let toLeft: CGFloat = fromVCIndex < toVCIndex ? 1 : -1
            var fromViewEndFrame = fromViewStartFrame
            fromViewEndFrame.origin.x -= fromViewEndFrame.size.width * toLeft
            var toViewStartFrame = toViewEndFrame
            toViewStartFrame.origin.x += toViewEndFrame.size.width * toLeft
            
            toView.frame = toViewStartFrame
            containerView.addSubview(toView)
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            UIView.animateWithDuration(Constants.transitionDuration,
                animations: {
                    fromView.frame = fromViewEndFrame
                    toView.frame = toViewEndFrame
            }, completion: { _ in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            })
        } else {
            transitionContext.completeTransition(true)
        }
        
        
    }
}

