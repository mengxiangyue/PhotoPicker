//
//  PhotoGroupTableViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit

class PhotoGroupTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "照片"
        let cancleBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancle:")
        self.navigationItem.rightBarButtonItem = cancleBarButtonItem
    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 22
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        return nil
//    }
    
    // MARK: - click
    func cancle(barButtonItme: UIBarButtonItem) {
        (self.navigationController as! PhotoPickerViewController).cancle()
    }

}
