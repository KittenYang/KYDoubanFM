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
   
/*
    aid = 26363982;
    album = "/subject/26363982/";
    albumtitle = "Avenues";
    artist = "Lera Lynn";
    company = "Not On Label";
    kbps = 64;
    length = 240;
    like = 0;
    picture = "http://img3.douban.com/lpic/s28045971.jpg";
    "public_time" = 2014;
    "rating_avg" = "3.49894";
    sha256 = c3b21c2c93dc80ba6d851bee53e289ffb328c280a50b409b451c3732f70cd226;
    sid = 2431456;
    "songlists_count" = 0;
    ssid = 77a9;
    subtype = "";
    title = "Sailor Song";
    url = "http://mr3.douban.com/201504130055/f8359542b5f116150ababc8fa547007f/view/song/small/p2431456.mp3";
*/
    var delegate : doubanModelProtocol?
//    var songList : NSArray = NSArray()
//    var channelList : NSArray = NSArray()
    
    //属性
    var aid : NSNumber = NSNumber()
    var album : String = String()
    var albumtitle : String = String()
    var artist : String = String()
    var company : String = String()
    var kbps : NSNumber = NSNumber()
    var length : NSNumber = NSNumber()
    var like : NSNumber = NSNumber()
    var picture : String = String()
    var public_time : NSNumber = NSNumber()
    var rating_avg : NSNumber = NSNumber()
    var sha256 : String = String()
    var sid : String = String()
    var songlists_count : NSNumber = NSNumber()
    var ssid : NSNumber = NSNumber()
    var subtype : String  = String()
    var title : String = String()
    var url : String = String()
    
    
    func searchWithUrl(url:String){
        var URL : NSURL = NSURL(string: url)!
        var REQUEST : NSURLRequest = NSURLRequest(URL: URL)
        NSURLConnection.sendAsynchronousRequest(REQUEST, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            var jsonResult : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: nil) as! NSDictionary
            
//            if (jsonResult["song"] != nil){
//                self.songList = jsonResult["song"] as! NSArray
//                self.setUpSongList(self.songList)
//                
//            }else if (jsonResult["channels"] != nil){
//                self.songList = jsonResult["channels"] as! NSArray
//            }
            
            //"?"语法的优点显示出来了：以往在OC中需要使用 if (self.delegate respondsToSelector:) 现在只要一个”?“就行了
            self.delegate?.didRecieveResults(jsonResult)
            
        })
        
    }
    
    func setUpSongList(list:NSArray){
//        self.aid = list[]
    }
    
}

