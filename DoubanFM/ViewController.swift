//
//  ViewController.swift
//  DoubanFM
//
//  Created by Kitten Yang on 4/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit
import MediaPlayer
import QuartzCore

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,doubanModelProtocol,channelProtocol{

    @IBOutlet var cover: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progress: UIProgressView!

    // 用一个字典保存对应的地址和图片到本地
    var imgCache = Dictionary<String,UIImage>()
    var audioPlayer : MPMoviePlayerController = MPMoviePlayerController() //播放器实例
    var doubanModel : DoubanModel = DoubanModel()
    var songsList : NSArray = NSArray()    //歌曲列表
    var channelsList : NSArray = NSArray() //频道列表
    var timer:NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        doubanModel.delegate = self
        doubanModel.searchWithUrl("http://www.douban.com/j/app/radio/channels") //频道列表
        doubanModel.searchWithUrl("http://douban.fm/j/mine/playlist?channel=0") //歌曲列表
        
        self.progress.progress = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        cell.layer.transform = CATransform3DScale(cell.layer.transform, 0.1, 0.1, 0.1)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            cell.layer.transform = CATransform3DIdentity
        })
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
            let imgURL : NSURL =  NSURL(string: url)!
            let request : NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                var img = UIImage(data: data)
                doubanCell.imageView?.image = img
                self.imgCache[url] = img
            })
        }else{
            doubanCell.imageView?.image = image
        }
        
        return doubanCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let rowData : NSDictionary = self.songsList[indexPath.row] as! NSDictionary
        let audioUrl : String = rowData["url"] as! String
        onSetAudio(audioUrl)
        let imageUrl : String = rowData["picture"] as! String
        onSetImage(imageUrl)
        
    }
    
    
    func onChangeChannel(channel_id:String){
        let channelUrl : String = "http://douban.fm/j/mine/playlist?\(channel_id)"
        doubanModel.searchWithUrl(channelUrl)
    }
    
    func didRecieveResults(results:NSDictionary){
        if (results["song"] != nil) {
            println(results)
            self.songsList = results["song"] as! NSArray
            self.tableView.reloadData()
            
            //默认播放第一条数据音乐
            let firstDic : NSDictionary = self.songsList[0] as! NSDictionary
            let audioUrl : String = firstDic["url"] as! String
            onSetAudio(audioUrl)
            let imgUrl : String  = firstDic["picture"] as! String
            onSetImage(imgUrl)
            
        }else if(results["channels"] != nil){
            self.channelsList = results["channels"] as! NSArray
        }
        
    }
    

    //页面跳转的时候把数组传过去
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var channelVC : ChanelViewController = segue.destinationViewController as! ChanelViewController
        channelVC.delegate = self
        channelVC.channelData = self.channelsList
    }
    
    func onSetAudio(url:String){
        timer?.invalidate()
        timeLabel.text = "00:00"
        self.audioPlayer.stop()
        self.audioPlayer.contentURL = NSURL(string: url)
        self.audioPlayer.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    
    func updateTime (){
        let currentPlaybackTime = audioPlayer.currentPlaybackTime // 已经播放的时间
        if (currentPlaybackTime > 0.0){
            //设置进度条
            let duration = audioPlayer.duration
            let percent : CFloat = CFloat(min(1, max(0, (currentPlaybackTime/duration))))
            self.progress .setProgress(percent, animated: true)
            
            //设置文本时间
            let allSeconds : Int = Int(currentPlaybackTime)
            let minute : Int = (allSeconds - allSeconds % 60) % 60
            let second : Int = allSeconds % 60
            self.timeLabel.text = "\(minute):\(second)"
        }
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






