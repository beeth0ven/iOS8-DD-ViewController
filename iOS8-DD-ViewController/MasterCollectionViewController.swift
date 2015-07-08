//
//  MasterCollectionViewController.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/6/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit




class MasterCollectionViewController: UICollectionViewController {

    private struct Storyboard {
        static let CellReuseIdentifier = "Cell"
        static let SectionHeaderReuseIdentifier = "Header"
        static let ShowDetailSegueIdentifier = "push"
    }
    
    var sectionNames = [String]()
    var sectionData = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fileURL = NSBundle.mainBundle().pathForResource("states", ofType: "txt")!
        let statesString = String(contentsOfFile: fileURL,
            encoding: NSUTF8StringEncoding,
            error: nil)!
        let states = statesString.componentsSeparatedByString("\n")
        var previousLetter = ""
        for state in states {
            let firstLetter = (state as NSString).substringWithRange(NSMakeRange(0, 1))
            if firstLetter != previousLetter {
                previousLetter = firstLetter
                sectionNames.append(firstLetter.uppercaseString)
                sectionData.append([String]())
            }
            sectionData[sectionData.count-1].append(state)
        }
        collectionView!.allowsMultipleSelection = true
    }
    
    @IBAction func Push(sender: UIBarButtonItem) {
        performSegueWithIdentifier(Storyboard.ShowDetailSegueIdentifier, sender: sender)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionNames.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionData[section].count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        println("cellForItemAtIndexPath")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        // Configure the cell
        if let label = cell.viewWithTag(1) as? UILabel {
            if label.text == "Label" {
                
                // Draw checkmark in top left if needed
                UIGraphicsBeginImageContextWithOptions(cell.bounds.size, false, 0)
                let con = UIGraphicsGetCurrentContext()
                let shadow = NSShadow()
                shadow.shadowColor = UIColor.darkGrayColor()
                shadow.shadowOffset = CGSizeMake(2,2)
                shadow.shadowBlurRadius = 4
                let check2 =
                NSAttributedString(string:"\u{2714}", attributes:[
                    NSFontAttributeName: UIFont(name:"ZapfDingbatsITC", size:24)!,
                    NSForegroundColorAttributeName: UIColor.greenColor(),
                    NSStrokeColorAttributeName: UIColor.redColor(),
                    NSStrokeWidthAttributeName: -4,
                    NSShadowAttributeName: shadow
                    ])
                CGContextScaleCTM(con, 1.1, 1)
                check2.drawAtPoint(CGPointMake(2,0))
                let im = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                let iv = UIImageView(image:nil, highlightedImage:im)
                iv.userInteractionEnabled = false
                cell.addSubview(iv)
            }
            
            label.text = sectionData[indexPath.section][indexPath.row]
            var stateName = label.text!
            stateName = stateName.lowercaseString
            stateName = stateName.stringByReplacingOccurrencesOfString(" ", withString: "")
            stateName = "flag_\(stateName).gif"
            let image = UIImage(named: stateName)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .ScaleAspectFit
            cell.backgroundView = imageView
        }
    
        return cell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var view: UICollectionReusableView! = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            view = collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                withReuseIdentifier: Storyboard.SectionHeaderReuseIdentifier,
                forIndexPath: indexPath) as! UICollectionReusableView
            let label = view.viewWithTag(1) as! UILabel
            label.text = sectionNames[indexPath.section]
        }
        return view
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        var size = CGSizeZero
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
//        if let label = cell.viewWithTag(1) as? UILabel {
//            label.text = sectionData[indexPath.section][indexPath.row]
//            var size = cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//            size.width = ceil(size.width); size.height = ceil(size.height)
//        }
        return CGSizeMake(50, 50)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
