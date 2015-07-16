//
//  PhotoPickerHelper.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/15.
//  Copyright © 2015年 mxy. All rights reserved.
//

import Foundation
import Photos

class PhotoPickerHelper {
    // 所有的照片分组
    var photoGroups = [PhotoGroup]()
    
    var imageManager: PHCachingImageManager!
    
    static let sharedInstance = {
            return PhotoPickerHelper()
        }()
    
    private init() {
        self.imageManager = PHCachingImageManager()
        
        // 所有图片
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let assetsFetchResults = PHAsset.fetchAssetsWithOptions(options)
        if assetsFetchResults.count > 0 {
            // TODO: 国际化
            let photoGroup = PhotoGroup(groupName: "所有图片", assetsFetchResult: assetsFetchResults)
            self.photoGroups += [photoGroup]
        }
        
        // 默认图片分组
        let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype:.AlbumRegular , options: nil)
        for var i = 0; i < smartAlbums.count; i++ {
            let collection = smartAlbums[i] as! PHAssetCollection
            let assetsFetchResults = PHAsset.fetchAssetsInAssetCollection(smartAlbums[i] as! PHAssetCollection, options: nil)
            if assetsFetchResults.count > 0 {
                let photoGroup = PhotoGroup(groupName: collection.localizedTitle, assetsFetchResult: assetsFetchResults)
                self.photoGroups += [photoGroup]
            }
        }
        
        // 用户自定义分组
        let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
        for var i = 0; i < topLevelUserCollections.count; i++ {
            let collection = topLevelUserCollections[i] as! PHAssetCollection
            let assetsFetchResults = PHAsset.fetchAssetsInAssetCollection(smartAlbums[i] as! PHAssetCollection, options: nil)
            if assetsFetchResults.count > 0 {
                let photoGroup = PhotoGroup(groupName: collection.localizedTitle, assetsFetchResult: assetsFetchResults)
                self.photoGroups += [photoGroup]
            }
        }
    }
    
    // 获取某个分组的第一张照片缩略图
    func firstPhotoThumbnails(photoGroup: PhotoGroup, resultHandler: (UIImage?, [NSObject : AnyObject]?) -> Void) {
        self.photoThumbnails(photoGroup.assetsFetchResult.firstObject as! PHAsset, resultHandler: resultHandler)
    }
    
    // 获取分组内的照片
    
    // 获取某一张照片缩略图
    func photoThumbnails(asset: PHAsset!, resultHandler: (UIImage?, [NSObject : AnyObject]?) -> Void) {
        let scale = UIScreen.mainScreen().scale
        let options = PHImageRequestOptions()
        options.resizeMode = .Fast
        
        self.imageManager.requestImageForAsset(asset, targetSize: CGSize(width: 88 * scale, height: 88 * scale), contentMode: .AspectFill, options: options, resultHandler: resultHandler)
    }
}


struct PhotoGroup {
    var groupName: String!
    var photoCount: Int! {
        return self.assetsFetchResult.count
    }
    // 每一个项目对应的Asserts
    var assetsFetchResult: PHFetchResult!
    
}