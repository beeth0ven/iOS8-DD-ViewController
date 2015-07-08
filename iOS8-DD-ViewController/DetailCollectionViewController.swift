//
//  DetailCollectionViewController.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/6/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

class DetailCollectionViewController: UICollectionViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        useLayoutToLayoutNavigationTransitions = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout {
            flow.headerReferenceSize = CGSizeMake(50, 50)
            flow.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10)
        }
        collectionView!.reloadData()
    }
    
    

    @IBAction func doFlush(sender: UIBarButtonItem) {
        if let layout = collectionView!.collectionViewLayout as? MyFlowLayout {
            layout.flush()
        }
    }

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let collectionViewController = navigationController!.viewControllers.first as! MasterCollectionViewController
            let size = collectionViewController.collectionView(collectionView,
                layout: collectionViewLayout,
                sizeForItemAtIndexPath: indexPath)
            return size
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
//
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return 0
//    }
//
//
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //#warning Incomplete method implementation -- Return the number of items in the section
//        return 0
//    }
//
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
//    
//        // Configure the cell
//    
//        return cell
//    }

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
