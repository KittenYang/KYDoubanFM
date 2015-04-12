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
        NSURLConnection.sendAsynchronousRequest(REQUEST, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            var jsonResult : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: nil) as! NSDictionary
            
            self.delegate?.didRecieveResults(jsonResult)
            
        })
        
    }
    
}

