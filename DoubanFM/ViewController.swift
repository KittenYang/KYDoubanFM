//
//  ViewController.swift
//  DoubanFM
//
//  Created by Kitten Yang on 4/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,doubanModelProtocol{

    @IBOutlet var cover: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progress: UIProgressView!
    
    var audioPlayer : MPMoviePlayerController = MPMoviePlayerController() //播放器实例
    var doubanModel : DoubanModel = DoubanModel()
    var songsList : NSArray = NSArray()    //歌曲列表
    var channelsList : NSArray = NSArray() //频道列表

    // 用一个字典保存对应的地址和图片到本地
    var imgCache = Dictionary<String,UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doubanModel.delegate = self
        doubanModel.searchWithUrl("http://www.douban.com/j/app/radio/channels") //频道列表
        doubanModel.searchWithUrl("http://douban.fm/j/mine/playlist?channel=0") //歌曲列表
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.songsList.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let doubanCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "douban")
        let rowData = self.songsList[indexPath.row] as! NSDictionary
        doubanCell.textLabel?.text = rowData["title"] as? String
        doubanCell.detailTextLabel?.text = rowData["artist"] as? String

        //设置默认的图片
        doubanCell.imageView?.image = UIImage(named: "cover")
        
        //获取网络图片并做一个缓存
        let url = rowData["picture"] as! String
        let image = self.imgCache[url] as UIImage!

        //如果本地缓存（也就是那个字典）里面没有地址对应的图片，我们就去异步加载一下
        if (image == nil) {
            let imgURL : NSURL? =  NSURL(string: url)
            let request : NSURLRequest? = NSURLRequest(URL: imgURL!)
            NSURLConnection.sendAsynchronousRequest(request!, queue: NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                var img = UIImage(data: data)
                doubanCell.imageView?.image = img
                self.imgCache[url] = img
            })
        }else{
            doubanCell.imageView?.image = image
        }
        
        return doubanCell
    }
    
    
    func didRecieveResults(results:NSDictionary){
        if (results["song"] != nil) {
            println(results)
            self.songsList = results["song"] as! NSArray
            self.tableView.reloadData()
            
        }else if(results["channels"] != nil){
            self.channelsList = results["channels"] as! NSArray
        }
        
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toChannel" {
            println("YES,it's toChannel")
        }
    }
    
    func onSetAudio(url:String){
        self.audioPlayer.stop()
        self.audioPlayer.contentURL = NSURL(string: url)
        self.audioPlayer.play()
    }
    
    func onSetImage(url:String){
        let image = self.imgCache[url] as UIImage!
        if (image == nil){
            let imgURL : NSURL = NSURL(string: url)!
            let req : NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue(), completionHandler: { (resp:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                let image = UIImage(data: data)
                self.cover.image = image
                self.imgCache[url] = image
            })
        }else{
            self.cover.image = image
        }
        
    }

}






