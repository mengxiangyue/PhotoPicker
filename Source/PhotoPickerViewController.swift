//
//  PhotoPickerViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import SnapKit

public class PhotoPickerViewController: UINavigationController {
    
    var customToolbar: UIToolbar!
    var previewBarButtonItem: UIBarButtonItem!
    var selectNumberBarButtonItem: UIBarButtonItem!
    var doneBarButtonItem: UIBarButtonItem!
    
    
    // MARK: - init 为了实现一个无参数的构造方法 下面必须写上其他的两个方法 也是无奈了
    public init() {
        let photoGroupTableViewController = PhotoGroupTableViewController()
        super.init(rootViewController: photoGroupTableViewController)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // 修改导航栏等
        self.navigationBar.translucent = true
        self.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationBar.tintColor = UIColor.whiteColor()
        
        self.toolbarHidden = false
        self.customToolbar = UIToolbar()
        self.customToolbar.tintColor = UIColor.whiteColor()
        self.customToolbar.barStyle = UIBarStyle.Black
        
        self.previewBarButtonItem = UIBarButtonItem(title: "预览", style: UIBarButtonItemStyle.Plain, target: self, action: "preview")
        self.previewBarButtonItem.enabled = false
        
        self.selectNumberBarButtonItem = UIBarButtonItem(title: "0/\(PhotoPickerHelper.sharedInstance.allowMaxSelectedAssets)", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.selectNumberBarButtonItem.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "assetCountChange:", name: PhotoPickerHelper.sharedInstance.assetCountChageNotification, object: nil)
        
        self.doneBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: "choiceDone")
        
        let items: [UIBarButtonItem] = [self.createFixBarButtonItem(UIBarButtonSystemItem.FixedSpace),
                    self.previewBarButtonItem,
                    self.createFixBarButtonItem(UIBarButtonSystemItem.FlexibleSpace),
                    self.selectNumberBarButtonItem,
                    self.createFixBarButtonItem(UIBarButtonSystemItem.FlexibleSpace),
                    self.doneBarButtonItem,
                    self.createFixBarButtonItem(UIBarButtonSystemItem.FixedSpace)]
        self.customToolbar.setItems(items, animated: false)
        
        
        self.view.addSubview(customToolbar)
        
        self.customLayout()
        
        PhotoPickerHelper.sharedInstance.clearSelectedAsset()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "overSelectedAsset:", name: PhotoPickerHelper.sharedInstance.overMaxSelectedNumberNotification, object: nil)
        
    }
    
    // 定义布局
    func customLayout() {
        self.customToolbar.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(self.toolbar)
        }
    }
    
    func createFixBarButtonItem(systemItem: UIBarButtonSystemItem) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil)
    }
    
    // MARK: - 
    func cancle() {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    // MARK: - UI change
    func assetCountChange(notification: NSNotification) {
        let selectCount = PhotoPickerHelper.sharedInstance.selectedPhotos.count
        self.selectNumberBarButtonItem.title = "\(selectCount)/\(PhotoPickerHelper.sharedInstance.allowMaxSelectedAssets)"
        self.previewBarButtonItem.enabled = selectCount > 0
        self.selectNumberBarButtonItem.enabled = selectCount > 0
        self.doneBarButtonItem.enabled = selectCount > 0
    }
    
    func overSelectedAsset(notification: NSNotification) {
        UIAlertView(title: "小主", message: "您最多只能选择\(PhotoPickerHelper.sharedInstance.allowMaxSelectedAssets)", delegate: nil, cancelButtonTitle: "确定").show()
    }
    
    // MARK: - BarButtonClick:
    func preview() {
        let photoBrowserViewController = PhotoBrowserViewController()
        self.pushViewController(photoBrowserViewController, animated: true)
    }
    
    func choiceDone() {
        print("click choiceDone")
        self.cancle()
    }
    
}
