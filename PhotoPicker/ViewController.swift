//
//  ViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import PhotoPicker
import Photos

class ViewController: UIViewController, PhotoPickerViewControllerDelegate {
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "rightButtonClick:")
        self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
        
    }

    func rightButtonClick(buttonItem: UIBarButtonItem) {
        let photoPickerViewController = PhotoPickerViewController()
        photoPickerViewController.photoPickerDelegate = self
        self.presentViewController(photoPickerViewController, animated: true, completion: nil)
    }
    
    func photoPickerDidFinish(photos: [PHAsset]) {
        for var i = 0; i < photos.count; i++ {
            let imageView = UIImageView(frame: CGRect(x: 0, y: i * 88 + 66, width: 88, height: 88))
            PhotoPickerHelper.sharedInstance.photoThumbnails(photos[i], resultHandler: { (image, userInfo) -> Void in
                imageView.image = image 
            })
            self.view.addSubview(imageView)
        }
    }


}

