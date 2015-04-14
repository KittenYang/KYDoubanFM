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
    
    func searchWithUrl(url:String){
        var URL : NSURL = NSURL(string: url)!
        var REQUEST : NSURLRequest = NSURLRequest(URL: URL)
        NSURLConnection.sendAsynchronousRequest(REQUEST, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            var jsonResult : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: nil) as! NSDictionary
            
            //"?"语法的优点显示出来了：以往在OC中需要使用 if (self.delegate respondsToSelector:) 现在只要一个”?“就行了
            self.delegate?.didRecieveResults(jsonResult)
            
        })
    }
    
}

