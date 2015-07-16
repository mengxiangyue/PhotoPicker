//
//  PhotoCollectionViewCell.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photoImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoImageView = UIImageView(frame: self.bounds)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .ScaleAspectFill
        self.addSubview(photoImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        photoImageView = UIImageView(frame: self.bounds)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .ScaleAspectFill
        self.addSubview(photoImageView)
    }
}
