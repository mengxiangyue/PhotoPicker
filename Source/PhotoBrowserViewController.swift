//
//  PhotoBrowserViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/18.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import Photos

class PhotoBrowserViewController: UIViewController, UIPageViewControllerDataSource, PhotoViewClickDelegate {
    
    var photos: [PHAsset]!
    var photosPageViewController: UIPageViewController!
    var selectedView: UIButton!
    var currentViewControllerIndex: Int!
    var startIndex: Int! = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // rightBarButtonItem
        selectedView = UIButton(type: UIButtonType.Custom)
        selectedView.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        selectedView.layer.cornerRadius = 13
        selectedView.layer.borderColor = UIColor.whiteColor().CGColor
        selectedView.layer.borderWidth = 1
        selectedView.addTarget(self, action: "changeSelectedPhoto", forControlEvents: UIControlEvents.TouchUpInside)
        let item = UIBarButtonItem(customView: selectedView)
        self.navigationItem.rightBarButtonItem = item
        
        self.photosPageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey: 10])
        self.currentViewControllerIndex = startIndex
        let viewControllers = [self.viewControllerAtIndex(startIndex)]
        self.photosPageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.photosPageViewController.dataSource = self
        
        self.addChildViewController(self.photosPageViewController)
        self.view.addSubview(self.photosPageViewController.view)
        self.photosPageViewController.didMoveToParentViewController(self)
        
        self.customLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as! PhotoPickerViewController).setLeftBarButtonItemHidden(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        (self.navigationController as! PhotoPickerViewController).setLeftBarButtonItemHidden(false)
    }
    
    func customLayout() {
        self.photosPageViewController.view.snp_makeConstraints { (make) -> Void in
            
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = Int((viewController as! PhotoViewController).index)
        if index == 0 || index == NSNotFound {
            return nil
        }
        self.currentViewControllerIndex = index
        index--
        return self.viewControllerAtIndex(index)
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = Int((viewController as! PhotoViewController).index)
        if index == NSNotFound {
            return nil
        }
        self.currentViewControllerIndex = index
        index++
        if index == self.photos.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    
    func viewControllerAtIndex(index: Int) -> PhotoViewController {
        let photoViewController = PhotoViewController()
        photoViewController.index = index
        photoViewController.asset = self.photos[index]
        photoViewController.delegate = self
        self.setSelected(PhotoPickerHelper.sharedInstance.isSelected(self.photos[index]))
        return photoViewController
    }
    
    // MARK: - bar
    func singleTap() {
//        if let hidden = self.navigationController?.navigationBarHidden {
//            self.navigationController?.setNavigationBarHidden(!hidden, animated: true)
//            (self.navigationController as! PhotoPickerViewController).setCustomToolbarHiddent(!hidden, animated: true)
//        }
        
    }
    
    func changeSelectedPhoto() {
        let selected = PhotoPickerHelper.sharedInstance.isSelected(self.photos[self.currentViewControllerIndex])
        if selected {
            PhotoPickerHelper.sharedInstance.removeSelectedAsset(self.photos[self.currentViewControllerIndex])
        } else {
            PhotoPickerHelper.sharedInstance.addSelectedAsset(self.photos[self.currentViewControllerIndex])
        }
        self.setSelected(!selected)
    }
    
    func setSelected(selected: Bool) {
        self.selectedView.backgroundColor = selected ? UIColor.blueColor() : UIColor.blackColor().colorWithAlphaComponent(0.2)
    }
    
    
}
