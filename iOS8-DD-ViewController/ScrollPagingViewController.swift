//
//  ScrollPagingViewController.swift
//  iOS8-DD-ViewController
//
//  Created by luojie on 7/5/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit


class ScrollPagingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    

    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let size = scrollView.bounds.size
        let colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.yellowColor()] //Scoll View Content Model
        for index in 0 ..< count(colors)  {
            let frame = CGRectMake(CGFloat(index)*size.width, 0, size.width, size.height)
            let view = UIView(frame: frame) //Scoll View Content Views
            view.backgroundColor = colors[index]
            scrollView.addSubview(view)
        }
        
        scrollView.contentSize = CGSizeMake(CGFloat(count(colors))*size.width, size.height)
        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        println("begin")
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        println("end")
        let offsetX = scrollView.contentOffset.x
        let width = scrollView.bounds.size.width
        pageControl.currentPage = Int(offsetX/width)
    }
    
    @IBAction func userDidPage(sender: UIPageControl) {
        let currentPage = pageControl.currentPage
        let width = scrollView.bounds.size.width
        scrollView.setContentOffset(CGPointMake(CGFloat(currentPage)*width, 0), animated: true)
    }
    
}
