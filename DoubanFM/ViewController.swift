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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doubanModel.delegate = self
        doubanModel.searchWithUrl("http://www.douban.com/j/app/radio/channels")
        doubanModel.searchWithUrl("http://douban.fm/j/mine/playlist?channel=0")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 20
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let doubanCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "douban")
        return doubanCell
    }
    
    
    func didRecieveResults(results:NSDictionary){
        println("================")
        println(results)
        
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toChannel" {
            println("YES,it's toChannel")
        }
    }

}






