//
//  PhotoBrowserViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/18.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import Photos

class PhotoBrowserViewController: UIViewController {
    
    var isBrowserSelected: Bool = false // 是否浏览的是已经选中的Photo
    var photos: [PHAsset]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedView = UIButton(type: UIButtonType.Custom)
        selectedView.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        selectedView.layer.cornerRadius = 13
        selectedView.layer.borderColor = UIColor.whiteColor().CGColor
        selectedView.layer.borderWidth = 1
        selectedView.addTarget(self, action: "selectedPhoto", forControlEvents: UIControlEvents.TouchUpInside)
        let item = UIBarButtonItem(customView: selectedView)
        self.navigationItem.rightBarButtonItem = item   
    }

}
