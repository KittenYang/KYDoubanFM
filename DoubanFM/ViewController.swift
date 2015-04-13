//
//  ViewController.swift
//  DoubanFM
//
//  Created by Kitten Yang on 4/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,doubanModelProtocol{

    @IBOutlet var cover: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progress: UIProgressView!
    
    var doubanModel : DoubanModel = DoubanModel()
    var songsList : NSArray = NSArray()    //歌曲列表
    var channelsList : NSArray = NSArray() //频道列表
    
    
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
        doubanCell.textLabel?.text = self.songsList[indexPath.row]["title"] as? String
        doubanCell.detailTextLabel?.text = self.songsList[indexPath.row]["artist"] as? String
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

}






