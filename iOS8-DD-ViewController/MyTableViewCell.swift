//
//  MyTableViewCell.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/5/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func didTransitionToState(state: UITableViewCellStateMask) {
        let editing = UITableViewCellStateMask.ShowingEditControlMask.rawValue
        if state.rawValue & editing != 0 {
            // Editing Mode
            textField.enabled = true
        } else {
            textField.enabled = false
        }
    }
    
}
