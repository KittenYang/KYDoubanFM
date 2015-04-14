//
//  ChanelViewController.swift
//  DoubanFM
//
//  Created by Kitten Yang on 4/10/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit

class ChanelViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,doubanModelProtocol {

    @IBOutlet var channelTableView: UITableView!

    var channelData:NSArray = NSArray()
    var channelModel : DoubanModel = DoubanModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelModel.delegate = self
        channelModel.searchWithUrl("http://www.douban.com/j/app/radio/channels")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return channelData.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let channelCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "channel")
        let rowData : NSDictionary = self.channelData[indexPath.row] as! NSDictionary
        channelCell.textLabel?.text = rowData["name"] as? String
        return channelCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didRecieveResults(results:NSDictionary){
        
        self.channelData = results["channels"] as! NSArray
        self.channelTableView.reloadData()
//        println(results)
    }
    

}









