//
//  DemoPopoverViewController.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/8/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class DemoPopoverViewController: UIViewController {
    
    private struct Storyboard {
        static let ShowFilterSegueIdentifier = "Show Filter"
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == Storyboard.ShowFilterSegueIdentifier {
                if let navigationController = segue.destinationViewController as? UINavigationController {
                    navigationController.delegate = self
                    if let ppc = navigationController.popoverPresentationController {
                        ppc.delegate = self
                    }
                    
                }
            }
        }
    }
}

extension DemoPopoverViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}

extension DemoPopoverViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        
        navigationController.preferredContentSize = viewController.preferredContentSize
    }
}