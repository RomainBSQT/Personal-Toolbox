//
//  UIColor+RBTColors.swift
//  SkidPatch
//
//  Created by Romain Bousquet on 14/10/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func rgb(red redV: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: redV/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
    
    class func grayWithRGB(white: CGFloat) -> UIColor {
        return UIColor.rgb(red: white, green: white, blue: white)
    }
    
    class func RBTRed() -> UIColor {
        return UIColor.rgb(red: 255, green: 102.0, blue: 51.0)
    }
    
    class func RBTGreen() -> UIColor {
        return UIColor.rgb(red: 0, green: 204.0, blue: 102.0)
    }
    
    class func RBTYellow() -> UIColor {
        return UIColor.rgb(red: 255, green: 204.0, blue: 255)
    }
    
    class func RBTGrayLight() -> UIColor {
        return UIColor.grayWithRGB(153.0)
    }
    
    class func RBTGray() -> UIColor {
        return UIColor.grayWithRGB(74.0)
    }
    
    class func RBTGrayStrong() -> UIColor {
        return UIColor.grayWithRGB(44.0)
    }
    
}
