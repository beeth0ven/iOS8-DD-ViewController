//
//  ViewController.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 6/19/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabBarController?.delegate = self
    }
    
    var tabBarPushAnimation = TabBarPushAnimation()

}


extension ViewController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController,
        animationControllerForTransitionFromViewController
        fromVC: UIViewController,
        toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            tabBarPushAnimation.tabBarController = tabBarController
            return tabBarPushAnimation
    }
}
