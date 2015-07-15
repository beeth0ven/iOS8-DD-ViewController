//
//  SearchBarViewController.swift
//  
//
//  Created by luojie on 7/15/15.
//
//

import UIKit


func imageFromContextOfSize(size:CGSize, closure:() -> ()) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    closure()
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result
}


class SearchBarViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.searchBarStyle = .Default
            searchBar.barStyle = .Default
            searchBar.translucent = true
            searchBar.barTintColor = UIColor.grayColor()
            
            let linImage = UIImage(named: "linen")!
            let linResizableImage =
            linImage.resizableImageWithCapInsets(
                UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1),
                resizingMode: .Stretch
            )
            
            searchBar.setBackgroundImage(linResizableImage, forBarPosition: .Any, barMetrics: .Default)
            searchBar.setBackgroundImage(linResizableImage, forBarPosition: .Any, barMetrics: .DefaultPrompt)
            
            let speiaImage = imageFromContextOfSize(CGSizeMake(320, 20)){
                UIBezierPath(roundedRect: CGRectMake(5, 0, 320-5*2, 20), cornerRadius: 8).addClip()
                UIImage(named: "sepia")!.drawInRect(CGRectMake(0, 0, 320, 20))
            }
            
            searchBar.setSearchFieldBackgroundImage(speiaImage, forState: .Normal)
            searchBar.searchFieldBackgroundPositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
            
            for view in (searchBar.subviews.first as! UIView).subviews as! [UIView] {
                if let textField = view as? UITextField {
                    textField.textColor = UIColor.whiteColor()
                    break
                }
            }
            
            searchBar.text = "Search me!"
            
            let mannyImage = UIImage(named: "manny")!
            searchBar.setImage(mannyImage, forSearchBarIcon: .Search, state: .Normal)
            let mannySmallImage = imageFromContextOfSize(CGSizeMake(20, 20)) {
                mannyImage.drawInRect(CGRectMake(0, 0, 20, 20))
            }
            searchBar.setImage(mannySmallImage, forSearchBarIcon: .Clear, state: .Normal)
            
            let moeImage = UIImage(named: "moe.jpg")!
            let moeSmallImage = imageFromContextOfSize(CGSizeMake(20, 20)) {
                moeImage.drawInRect(CGRectMake(0, 0, 20, 20))
            }
            searchBar.setImage(moeSmallImage, forSearchBarIcon: .Clear, state: .Highlighted)
            
            searchBar.showsScopeBar = true
            searchBar.scopeButtonTitles = ["Manny", "Moe", "Jack"]
            
            searchBar.scopeBarBackgroundImage = UIImage(named: "sepia")
            searchBar.setScopeBarButtonBackgroundImage(linResizableImage, forState: .Normal)
            
            let divideImage = imageFromContextOfSize(CGSizeMake(2, 2)) {
                UIColor.whiteColor().setFill()
                UIBezierPath(rect: CGRectMake(0, 0, 2, 2)).fill()
            }
            searchBar.setScopeBarButtonDividerImage(divideImage,
                forLeftSegmentState: .Normal,
                rightSegmentState: .Normal
            )
            
            let attributes = [
                NSFontAttributeName: UIFont(name: "GillSans-Bold", size: 16)!,
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSShadowAttributeName: lend {
                    (shad: NSShadow) in
                    shad.shadowColor = UIColor.grayColor()
                    shad.shadowOffset = CGSizeMake(2, 2)
                },
                NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleDouble.rawValue
            ]
            
            searchBar.setScopeBarButtonTitleTextAttributes(attributes, forState: .Normal)
            searchBar.setScopeBarButtonTitleTextAttributes(attributes, forState: .Selected)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

}



extension SearchBarViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
































