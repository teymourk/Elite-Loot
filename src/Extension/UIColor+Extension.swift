//
//  UIColor+Extension.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/30/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import UIKit

extension UIColor {
    
    //Override super init to create out own convenience init.
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    //App Color -> Gold
    static var gold: UIColor { return UIColor(red: 247, green: 196, blue: 70) }
}

