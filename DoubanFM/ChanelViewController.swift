//
//  ChanelViewController.swift
//  DoubanFM
//
//  Created by Kitten Yang on 4/10/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit

class ChanelViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 20
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let channelCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "channel")
        return channelCell
    }

}









