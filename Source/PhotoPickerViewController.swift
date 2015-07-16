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
        let photoGroupTableViewController = PhotoGroupTableViewController()
        self.presentViewController(photoGroupTableViewController, animated: false, completion: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // 修改导航栏等
        self.navigationBar.translucent = true
        self.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationBar.tintColor = UIColor.whiteColor()
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
//            let tempBarStyle = UIApplication.sharedApplication().statusBarStyle
//            if tempBarStyle != UIStatusBarStyle.LightContent {
//                UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
//            }
//        })
        
        self.toolbarHidden = false
        self.customToolbar = UIToolbar()
        self.customToolbar.tintColor = UIColor.whiteColor()
        self.customToolbar.barStyle = UIBarStyle.Black
        
        self.previewBarButtonItem = UIBarButtonItem(title: "　　", style: UIBarButtonItemStyle.Plain, target: self, action: "preview")
        self.selectNumberBarButtonItem = UIBarButtonItem(title: "0/9", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        let doneBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: "choiceDone")
        let items: [UIBarButtonItem] = [self.createFixBarButtonItem(UIBarButtonSystemItem.FixedSpace),
                    self.previewBarButtonItem,
                    self.createFixBarButtonItem(UIBarButtonSystemItem.FlexibleSpace),
                    self.selectNumberBarButtonItem,
                    self.createFixBarButtonItem(UIBarButtonSystemItem.FlexibleSpace),
                    doneBarButtonItem,
                    self.createFixBarButtonItem(UIBarButtonSystemItem.FixedSpace)]
        self.customToolbar.setItems(items, animated: false)
        
        
        self.view.addSubview(customToolbar)
        
        self.customLayout()
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
    
}
