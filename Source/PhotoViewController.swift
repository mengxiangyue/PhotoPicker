//
//  PhotoView.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/18.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import Photos

protocol PhotoViewClickDelegate: NSObjectProtocol {
    func singleTap()
}


class PhotoViewController: UIViewController, UIScrollViewDelegate {
    var asset: PHAsset!
    var imageContainerScrollView: UIScrollView!
    var imageView: UIImageView!
    var index: Int! // 索引值
    weak var delegate: PhotoViewClickDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
        self.imageContainerScrollView = UIScrollView(frame: self.view.bounds)
        self.imageContainerScrollView.maximumZoomScale = 3.0
        self.imageContainerScrollView.minimumZoomScale = 1
        self.imageContainerScrollView.zoomScale = 1.0
        self.imageContainerScrollView.contentSize = self.view.frame.size
        self.imageContainerScrollView.delegate = self
        self.view.addSubview(self.imageContainerScrollView)

        self.imageView = UIImageView(frame: self.imageContainerScrollView.frame)
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        PhotoPickerHelper.sharedInstance.photoImage(self.imageView.bounds.size, asset: self.asset) { (image, userInfo) -> Void in
            self.imageView.image = image 
        }
        
        self.imageView.center = self.imageContainerScrollView.center
        self.imageContainerScrollView.addSubview(imageView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        singleTap.delaysTouchesBegan = true
        singleTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        // 只有单击没有响应才会响应双击
        singleTap.requireGestureRecognizerToFail(doubleTap)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    // 让UIImageView在UIScrollView缩放后居中显示
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let offsetX = self.imageContainerScrollView.bounds.size.width > self.imageContainerScrollView.contentSize.width ? (self.imageContainerScrollView.bounds.size.width - self.imageContainerScrollView.contentSize.width) * 0.5 : 0.0
        let offsetY = self.imageContainerScrollView.bounds.size.height > self.imageContainerScrollView.contentSize.height ? (self.imageContainerScrollView.bounds.size.height - self.imageContainerScrollView.contentSize.height) * 0.5 : 0.0
        self.imageView.center = CGPointMake(self.imageContainerScrollView.contentSize.width * 0.5 + offsetX,
            self.imageContainerScrollView.contentSize.height * 0.5 + offsetY);
    }
    
    
    // MARK: - click
    func handleSingleTap(tap: UITapGestureRecognizer) {
        self.delegate?.singleTap()
    }
    
    func handleDoubleTap(tap: UITapGestureRecognizer) {
        let touchPoint = tap.locationInView(self.view)
        if self.imageContainerScrollView.zoomScale > self.imageContainerScrollView.minimumZoomScale {
            self.imageContainerScrollView.setZoomScale(self.imageContainerScrollView.minimumZoomScale, animated: true)
        } else {
            self.imageContainerScrollView.zoomToRect(CGRect(x: touchPoint.x, y: touchPoint.y, width: 1, height: 1), animated: true)
        }
    }
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.imageContainerScrollView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.view.bounds.size.height, height: self.view.bounds.size.width))
        self.imageContainerScrollView.contentSize = self.imageContainerScrollView.bounds.size
        self.imageView.frame = self.imageContainerScrollView.bounds
        self.imageView.center = self.imageContainerScrollView.center
        self.view.layoutIfNeeded()
    }
    
    
}
