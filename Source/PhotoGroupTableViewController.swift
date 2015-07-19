//
//  PhotoGroupTableViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import Photos

class PhotoGroupTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PHPhotoLibraryChangeObserver {
    let groupTableViewCellIdentifier = "GroupTableViewCell"

    var groupTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupTableView = UITableView()
        self.groupTableView.dataSource = self
        self.groupTableView.delegate = self
        self.groupTableView.rowHeight = 66.0
//        self.groupTableView.separatorInset = UIEdgeInsetsZero
        self.groupTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.groupTableView.registerClass(PhotoGroupTableViewCell.self, forCellReuseIdentifier: groupTableViewCellIdentifier)
        self.view.addSubview(self.groupTableView)
        
        self.customLayout()
        
        self.pushFirstViewController(false)
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "照片"
        let cancleBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancle:")
        self.navigationItem.rightBarButtonItem = cancleBarButtonItem
        
        
    }
    
    deinit {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }
    
    func customLayout() {
        self.groupTableView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    func pushFirstViewController(animated: Bool) {
        if PhotoPickerHelper.sharedInstance.photoGroups.count > 0 {
            let photoGroup = PhotoPickerHelper.sharedInstance.photoGroups[0]
            let photoCollectionViewController = PhotoCollectionViewController()
            photoCollectionViewController.title = photoGroup.groupName
            photoCollectionViewController.photoGroup = photoGroup
            self.navigationController?.pushViewController(photoCollectionViewController, animated: animated)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhotoPickerHelper.sharedInstance.photoGroups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.groupTableViewCellIdentifier, forIndexPath: indexPath) as! PhotoGroupTableViewCell
        let photoGroup = PhotoPickerHelper.sharedInstance.photoGroups[indexPath.row]
        PhotoPickerHelper.sharedInstance.firstPhotoThumbnails(photoGroup) { (image, info) -> Void in
            cell.groupImageView.image = image
        }
        cell.groupNameLable.text = "\(photoGroup.groupName) (\(photoGroup.photoCount))"
        return cell        
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let photoGroup = PhotoPickerHelper.sharedInstance.photoGroups[indexPath.row]
        let photoCollectionViewController = PhotoCollectionViewController()
        photoCollectionViewController.photoGroup = photoGroup
        photoCollectionViewController.title = photoGroup.groupName
        self.navigationController?.pushViewController(photoCollectionViewController, animated: true)
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
//        dispatch_async(dispatch_get_main_queue(), ^{ }
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            PhotoPickerHelper.sharedInstance.generatePhotoGroups()
            self.groupTableView.reloadData()
            self.pushFirstViewController(true)
        }
            
        
    }
    
    // MARK: - click
    func cancle(barButtonItme: UIBarButtonItem) {
        (self.navigationController as! PhotoPickerViewController).cancle()
    }

}
