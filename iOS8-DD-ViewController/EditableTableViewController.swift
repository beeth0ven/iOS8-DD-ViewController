//
//  EditableTableViewController.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/5/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class EditableTableViewController: UITableViewController, UITextFieldDelegate {

    var numbers = [String]()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem()
        name = "Luo Jie"
        numbers = ["+86 153-4229-9921"]
        
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        }
        return numbers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier,
            forIndexPath: indexPath) as! MyTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.textField.text = name
        case 1:
            cell.textField.text = numbers[indexPath.row]
            cell.textField.keyboardType = .NumbersAndPunctuation
        default: break
        }
        cell.textField.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        switch indexPath.section {
        case 1:
            let lastRowInSection = tableView.numberOfRowsInSection(indexPath.section) - 1
            if indexPath.row == lastRowInSection {
                return .Insert
            } else {
                return .Delete
            }
        default: return .None
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Name"
        } else {
            return "Number"
        }

    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        }
        return false
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let number = numbers[sourceIndexPath.row]
        numbers.removeAtIndex(sourceIndexPath.row)
        numbers.insert(number, atIndex: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 1 && numbers.count > 1 {
            return true
        }
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Insert:
            numbers += [""]
            let lastRowInSection = tableView.numberOfRowsInSection(indexPath.section) - 1
            tableView.beginUpdates()
            let insertIndexPath = NSIndexPath(forRow: lastRowInSection, inSection: 1)
            tableView.insertRowsAtIndexPaths([insertIndexPath], withRowAnimation: .Automatic)
            let reloadIndexPath = NSIndexPath(forRow: lastRowInSection-1, inSection: 1)
            tableView.reloadRowsAtIndexPaths([reloadIndexPath], withRowAnimation: .Automatic)
            tableView.endUpdates()
            let lastCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: lastRowInSection, inSection: 1)) as! MyTableViewCell
            lastCell.textField.becomeFirstResponder()
        case .Delete:
            numbers.removeAtIndex(indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .Automatic)
            tableView.endUpdates()
        default: break
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var superView: UIView = textField
        do { superView = superView.superview! } while ((superView is UITableViewCell) == false)
        if let cell = superView as? MyTableViewCell {
            if let indexPath = tableView.indexPathForCell(cell) {
                if indexPath.section == 0 {
                   name = cell.textField.text
                } else if indexPath.section == 1 {
                    numbers[indexPath.row] = cell.textField.text
                }
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    private struct Storyboard {
        static let CellReuseIdentifier = "Cell"
//        static let ShowTweetDetailSegueIdentifier = "Show Tweet Detail"
    }

}
