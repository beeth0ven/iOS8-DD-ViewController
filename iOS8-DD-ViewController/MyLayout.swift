//
//  MyLayout.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/6/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class MyLayout: UICollectionViewLayout {
    
    var size = CGSizeZero
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
   
    override func prepareLayout() {
        let sections = collectionView!.numberOfSections()
        
        let total = Array(0 ..< sections).map {
            self.collectionView!.numberOfItemsInSection($0)
        }.reduce(0, combine: +)
        
        size = collectionView!.bounds.size
        let width = size.width
        let shortside = floor(width/50.0)
        let cellside = width/shortside
        
        var x = 0
        var y = 0
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for section in 0 ..< sections {
            let items = collectionView!.numberOfItemsInSection(section)
            for item in 0 ..< items {
                let attributes = UICollectionViewLayoutAttributes(
                    forCellWithIndexPath: NSIndexPath(forItem: item, inSection: section))
                attributes.frame = CGRectMake(CGFloat(x)*cellside, CGFloat(y)*cellside, cellside, cellside)
                layoutAttributes += [attributes]
                x++
                if CGFloat(x) >= shortside {
                    x = 0
                    y++
                }
            }
        }
        self.layoutAttributes = layoutAttributes
        let fluff = (x == 0) ? 0 : 1
        size = CGSizeMake(width, CGFloat(y+fluff)*cellside)
    }
    
    override func collectionViewContentSize() -> CGSize {
        return size
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        let should = newBounds.size.width != size.width
        return should
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        for attribute in layoutAttributes {
            if attribute.indexPath == indexPath {
                return attribute
            }
        }
        return nil
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        return layoutAttributes
    }
    
}
