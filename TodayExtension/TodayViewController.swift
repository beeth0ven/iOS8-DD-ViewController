//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by luojie on 7/20/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    @IBAction func doButton(sender: UIButton) {
        let tag = sender.tag
        if let url = NSURL(string: "coffeetime://\(String(tag))") {
            extensionContext?.openURL(url, completionHandler: nil)
        }
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 16, 0, 16)
    }
    
    
    
}
