//
//  ImageTextViewController.swift
//  
//
//  Created by luojie on 7/14/15.
//
//

import UIKit
import ImageIO

func lend<T where T:NSObject> (closure:(T)->()) -> T {
    let orig = T()
    closure(orig)
    return orig
}


class ImageTextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = "Onions\t$2.34\nPeppers\t$15.2\n"
        let attributes = [
            NSFontAttributeName: UIFont(name: "GillSans", size: 15)!,
            NSParagraphStyleAttributeName: lend {
                (p:NSMutableParagraphStyle) in
                var tabs = [NSTextTab]()
                let terms = NSTextTab.columnTerminatorsForLocale(NSLocale.currentLocale())
                let tab = NSTextTab(textAlignment:.Right, location:170, options:[NSTabColumnTerminatorsAttributeName:terms])
                tabs += [tab]
                p.tabStops = tabs
                p.firstLineHeadIndent = 20
            }
        ]

        let mas = NSMutableAttributedString(
            string: string,
            attributes: attributes
        )
        
        textView.attributedText = mas
        
        let onions = thumbnailOfImageWithName("onion", withExtension: "jpg")
        let peppers = thumbnailOfImageWithName("peppers", withExtension: "jpg")
        
        let onionAttachment = NSTextAttachment()
        onionAttachment.image = onions
        onionAttachment.bounds = CGRectMake(0, -5, onions.size.width, onions.size.height)
        let onionAttachmentChar = NSAttributedString(attachment: onionAttachment)
        
        let pepperAttachment = NSTextAttachment()
        pepperAttachment.image = peppers
        pepperAttachment.bounds = CGRectMake(0, -1, peppers.size.width, peppers.size.height)
        let pepperAttachmentChar = NSAttributedString(attachment: pepperAttachment)
        
        let onionsRange = (mas.string as NSString).rangeOfString("Onions")
        mas.insertAttributedString(onionAttachmentChar, atIndex: (onionsRange.location + onionsRange.length))
        
        let peppersRange = (mas.string as NSString).rangeOfString("Peppers")
        mas.insertAttributedString(pepperAttachmentChar, atIndex: (peppersRange.location + peppersRange.length))
        
        mas.appendAttributedString(NSAttributedString(string: "\n\n", attributes: nil))
        mas.appendAttributedString(
            NSAttributedString(
            string: "LINK",
            attributes: [NSLinkAttributeName: NSURL(string: "http://www.apple.com")!]
            )
        )
        mas.appendAttributedString(NSAttributedString(string: "\n\n", attributes: nil))
        mas.appendAttributedString(NSAttributedString(string: "(805)-123-4567", attributes: nil))
        mas.appendAttributedString(NSAttributedString(string: "\n\n", attributes: nil))
        mas.appendAttributedString(NSAttributedString(string: "123 Main Street, Anytown, CA 91234", attributes: nil))
        mas.appendAttributedString(NSAttributedString(string: "\n\n", attributes: nil))
        mas.appendAttributedString(NSAttributedString(string: "tomorrow at 4 PM", attributes: nil))
        
        textView.attributedText = mas
        textView.selectable = true
        textView.editable = false
        textView.delegate = self
    }
    
    func thumbnailOfImageWithName(name:String, withExtension ext: String) -> UIImage {
        let url = NSBundle.mainBundle().URLForResource(name,
            withExtension:ext)
        let src = CGImageSourceCreateWithURL(url, nil)
        let scale = UIScreen.mainScreen().scale
        let w : CGFloat = 20 * scale
        let d : [NSObject:AnyObject] = [
            kCGImageSourceShouldAllowFloat : true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: Int(w)
        ]
        let imref =
        CGImageSourceCreateThumbnailAtIndex(src, 0, d)
        let im = UIImage(CGImage:imref, scale:scale, orientation:.Up)!
        return im
    }
    

}

extension ImageTextViewController: UITextViewDelegate {
    func textView(textView: UITextView, shouldInteractWithTextAttachment textAttachment: NSTextAttachment, inRange characterRange: NSRange) -> Bool {
        return true
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }
}
