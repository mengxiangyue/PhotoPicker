//
//  PhotoGroupTableViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit

class PhotoGroupTableViewController: UIViewController, UITableViewDataSource {
    let groupTableViewCellIdentifier = "GroupTableViewCell"

    var groupTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupTableView = UITableView()
        self.groupTableView.dataSource = self
        self.groupTableView.rowHeight = 66.0
//        self.groupTableView.separatorInset = UIEdgeInsetsZero
        self.groupTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.groupTableView.registerClass(PhotoGroupTableViewCell.self, forCellReuseIdentifier: groupTableViewCellIdentifier)
        self.view.addSubview(self.groupTableView)
        
        self.customLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "照片"
        let cancleBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancle:")
        self.navigationItem.rightBarButtonItem = cancleBarButtonItem
        
    }
    
    func customLayout() {
        self.groupTableView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.groupTableViewCellIdentifier) as! PhotoGroupTableViewCell
        cell.groupImageView.image = UIImage(named: "1")
        cell.groupNameLable.text = "测试"
        return cell        
    }
    
    // MARK: - click
    func cancle(barButtonItme: UIBarButtonItem) {
        (self.navigationController as! PhotoPickerViewController).cancle()
    }

}
