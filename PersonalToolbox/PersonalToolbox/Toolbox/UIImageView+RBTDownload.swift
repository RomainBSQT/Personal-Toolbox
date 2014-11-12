//
//  UIImageView+RBTDownload.swift
//  PersonalToolbox
//
//  Created by Romain Bousquet on 06/11/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImage(url: String) {
        var url: NSURL = NSURL(string: url)!
        self.downloadImage(url)
    }
    
    func downloadImage(url: NSURL) {
        RBTNetworking.sharedInstance.downloadPicture(url, completionBlock: {
            (success, picture, isFromCache) -> Void in
            if (!success) {
                return
            }
            if (isFromCache != nil && isFromCache!) {
                self.alpha = 0
                self.image = picture
                UIView.animateWithDuration(0.2, animations: {
                    () -> Void in
                    self.alpha = 1
                })
            } else {
                self.alpha = 1
                self.image = picture
            }
        })
    }
    
}