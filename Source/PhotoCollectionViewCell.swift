//
//  PhotoCollectionViewCell.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    private var selectedView: UIView!
    var photoImageView: UIImageView!
    var photoSelected = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoImageView = UIImageView(frame: self.bounds)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .ScaleAspectFill
        self.addSubview(photoImageView)
        
        self.selectedView = UIView(frame: CGRect(x: self.frame.size.width - 30, y: 4, width: 26, height: 26))
        self.selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        self.selectedView.layer.cornerRadius = 13
        self.selectedView.layer.borderColor = UIColor.whiteColor().CGColor
        self.selectedView.layer.borderWidth = 1
        self.selectedView.userInteractionEnabled = false
        self.addSubview(self.selectedView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapCell:")
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        photoImageView = UIImageView(frame: self.bounds)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .ScaleAspectFill
        self.addSubview(photoImageView)
    }
    
    // MARK: - tap
    func tapCell(tap: UITapGestureRecognizer) {
        let location = tap.locationInView(self)
        if CGRectContainsPoint(CGRectInset(self.selectedView.frame, -5, -5), location) { // 点击在选择的按钮上
            print("选择")
            self.photoSelected = !self.photoSelected
            if self.photoSelected {
                self.selectedView.backgroundColor = UIColor.blueColor()
            } else {
                self.selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
            }
        } else {
            print("预览")
        }
    }
    
}
