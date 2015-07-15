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
        self.customToolbar = UIToolbar()
        self.view.addSubview(customToolbar)
    }
    
    func customLayout() {
        self.customToolbar.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(44)
        }
    }
    
    
    // MARK: - 
    func cancle() {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
}
