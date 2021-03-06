//
//  UIColor+Extension.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/30/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import UIKit

//Mark: - UIColor
extension UIColor {
    
    //Override super init to create out own convenience init.
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    //Secondary Color -> Blue
    static var lightBlue: UIColor { return UIColor(red: 18, green: 149, blue: 232) }
    static var customGray: UIColor { return UIColor(red: 238, green: 239, blue: 241) }
    static var softGray: UIColor { return UIColor(red: 210, green: 211, blue: 213) }
    static var coolGray: UIColor { return UIColor(red: 160, green: 164, blue: 165) } //0, 177, 106
    static var clearGray: UIColor { return UIColor(red: 160, green: 164, blue: 165).withAlphaComponent(0.95) }
    static var successGreen: UIColor { return UIColor(red: 0, green: 177, blue: 106) }
}

//Mark: - Int
extension Int {
    func doTask(_ task: (Int) -> Void) {
        for index in 0..<self {
            task(index)
        }
    }
 }

//Mark: - UITextField
extension UITextView {
    //Attributed string for the title, price and rating Icon
    func attributedFor(_ title: String, price: String, IncludesShipping:String? = nil, details:String? = nil) {
        
        guard   let textFont = UIFont(name: "Helvetica", size: 14) else { return }
                let attributedFont: Dictionary<NSAttributedStringKey, UIFont> = [.font :   textFont]
        

        let attributedText = NSMutableAttributedString( string: "\(title)\n", //Initialize Merch Details
                                                        attributes: attributedFont)
        
        
        let fontSize:CGFloat = IncludesShipping == nil ? 13 : 16
        let priceWithShipping = IncludesShipping == nil ? price : "\(price) \(IncludesShipping ?? "") \n"
        
        let priceAttributedString =  NSMutableAttributedString( string: "\(priceWithShipping)\n", //Price
                                                                attributes: [.font: UIFont.boldSystemFont(ofSize: fontSize)])
        if let shipping = IncludesShipping {
            priceAttributedString.addAttributes([.font: UIFont.systemFont(ofSize: 13)],
                                                range: NSRange(location: price.count + 1 - shipping.startIndex.encodedOffset,
                                                               length: shipping.count))
        }
        
        //Appending the attributes
        attributedText.append(priceAttributedString)
        self.attributedText = attributedText

        guard   let itemDetail = details else { return }
        let attributedDetailsText = NSMutableAttributedString(  string: itemDetail, //Initialize Merch Details
                                                                attributes: attributedFont)
        
        attributedText.append(attributedDetailsText)
        self.attributedText = attributedText
    }
}

//Mark: - UIButton {
extension UIButton {
    convenience init(title: String? = nil, imageName: UIImage? = nil) {
        self.init(frame: .zero)
        let image = imageName == nil ? nil : imageName,
            text = title == nil ? nil : title!
        setTitle(text, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
        setImage(image, for: .normal)
        setTitleColor(.darkText , for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//Mark: - String {
extension String {
    subscript (r: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

//Mark: - UIView
extension UIView {
    func shake() {
        self.isHidden = false
        let from: CGPoint = CGPoint(x: self.center.x - 5, y: self.center.y),
            to: CGPoint =  CGPoint(x: self.center.x + 5, y: self.center.y)
        let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 5
            animation.autoreverses = true
            animation.fromValue = from
            animation.toValue = to
        layer.add(animation, forKey: "position")
    }
    
    func flash() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                self.alpha = 0
            }, completion: nil)
        }
    }
}



