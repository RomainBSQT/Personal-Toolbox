//
//  RBTNetworking.swift
//  PersonalToolbox
//
//  Created by Romain Bousquet on 04/11/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

import UIKit
import Foundation

class RBTNetworking : NSObject, NSURLSessionDelegate {
    
    typealias CompletionBlock = (success: Bool, reponse: NSDictionary!) -> Void
    typealias PictureDownloadBlock = (success: Bool, picture: UIImage!, isFromCache: Bool!) -> Void
    
    var currentSession: NSURLSession!
    var pictureDownloadQueue: NSOperationQueue
    var pictureCache: NSCache
    
    class var sharedInstance : RBTNetworking {
        struct Static {
            static let instance: RBTNetworking = RBTNetworking()
        }
        return Static.instance
    }
    
    override init() {
        self.pictureDownloadQueue = NSOperationQueue()
        self.pictureDownloadQueue.maxConcurrentOperationCount = 6
        self.pictureCache = NSCache()
        super.init()
        var sessionConfiguration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.HTTPAdditionalHeaders = ["Accept": "application/json"]
        sessionConfiguration.timeoutIntervalForRequest  = 30
        sessionConfiguration.timeoutIntervalForResource = 60
        self.currentSession = NSURLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
    }
    
    func GETWithUrl(url: String, completionBlock: CompletionBlock!) {
        var url: NSURL = NSURL(string: url)!
        self.GETWithUrl(url, completionBlock: completionBlock)
    }
    
    func GETWithUrl(url: NSURL, completionBlock: CompletionBlock!) {
        let dataTask: NSURLSessionDataTask = self.currentSession.dataTaskWithURL(url, completionHandler: {
            (data, response, error) -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
                if (httpResp.statusCode == 200) {
                    var parseError: NSError?
                    var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &parseError) as? NSDictionary
                    if let err = parseError {
                        if (completionBlock != nil) {
                            completionBlock(success: false, reponse: nil)
                        }
                        return
                    }
                    if (completionBlock != nil) {
                        completionBlock(success: true, reponse: jsonResult!)
                    }
                    return
                }
            }
            if (completionBlock != nil) {
                completionBlock(success: false, reponse: nil)
            }
        })
        dataTask.resume()
    }
    
    func downloadPicture(url: NSURL, completionBlock: PictureDownloadBlock!) {
        var currentUrl: NSURL     = url.copy() as NSURL
        var pictureUrlStr: String = currentUrl.absoluteString!
        
        if let cachedPicture = self.pictureCache.objectForKey(pictureUrlStr) as? UIImage {
            if (completionBlock != nil) {
                completionBlock(success: true, picture: cachedPicture, isFromCache: false)
            }
        } else {
            self.pictureDownloadQueue.addOperationWithBlock({
                () -> Void in
                if let data = NSData(contentsOfURL: currentUrl) {
                    if let picture = UIImage(data: data) {
                        self.pictureCache.setObject(picture, forKey: pictureUrlStr)
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            () -> Void in
                            if (completionBlock != nil) {
                                completionBlock(success: true, picture: picture, isFromCache: false)
                            }
                            return
                        })
                    }
                }
                if (completionBlock != nil) {
                    completionBlock(success: false, picture: nil, isFromCache: nil)
                }
            })
        }
    }
    
    func downloadPictureWithProgress(url: NSURL, completionBlock: PictureDownloadBlock!) {
        
    }
    
}