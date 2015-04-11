//
//  DoubanModel.swift
//  DoubanFM
//
//  Created by Kitten Yang on 4/12/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit

protocol doubanModelProtocol {
    func didRecieveResults(results:NSDictionary)
}

class DoubanModel: NSObject {
   
    var delegate : doubanModelProtocol?
    
    func onSearch(url:String){
        var URL : NSURL = NSURL(string: url)!
        var REQUEST : NSURLRequest = NSURLRequest(URL: URL)
//        NSURLConnection.sendAsynchronousRequest(REQUEST, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
//
//        })
        
        NSURLConnection.sendAsynchronousRequest(REQUEST, queue: NSOperationQueue.mainQueue()) { (NSURLResponse, NSData, NSError) -> Void in
            
        }
    }
    
}

