//
//  PhotoPickerHelper.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/15.
//  Copyright © 2015年 mxy. All rights reserved.
//

import Foundation

class PhotoPickerHelper {
    var photoGroups: [PhotoGroup] {
        return self.photoGroups
    }
    
    static let sharedInstance = {
            return PhotoPickerHelper()
        }()
    
    private init() {
        
    }
    
    // 获取照片分组
    
    // 获取分组内的照片
    
    // 获取某一张照片
}


struct PhotoGroup {
    var groupName: String!
    var photoCount: Int!
    
}