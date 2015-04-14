//
//  ChanelViewController.swift
//  DoubanFM
//
//  Created by Kitten Yang on 4/10/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit

protocol channelProtocol{
    func onChangeChannel(channel_id:String)
}

class ChanelViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var channelTableView: UITableView!

    var channelData:NSArray = NSArray()
    var delegate : channelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        var rowData : NSDictionary = self.channelData[indexPath.row] as! NSDictionary
        let channel_id : AnyObject = rowData["channel_id"]!   // 使用AnyObject类型是因为豆瓣那边0的时候是int类型，1的时候是string类型
        let channel : String = "channel=\(channel_id)"
        self.delegate?.onChangeChannel(channel)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    


}









