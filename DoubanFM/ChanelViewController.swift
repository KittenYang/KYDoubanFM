//
//  ChanelViewController.swift
//  DoubanFM
//
//  Created by Kitten Yang on 4/10/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit

class ChanelViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var channelTableView: UITableView!
    
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
        
        return 20
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let channelCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "channel")
        return channelCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}









