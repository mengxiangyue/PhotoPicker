//
//  PhotoCollectionViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import Photos

class PhotoCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PhotoCollectionViewCellDelegage {
    let photoCollectionViewIdentifier = "PhotoCollectionViewCell"
    var photoGroup: PhotoGroup!
    var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.minimumLineSpacing = 3.0 // 行间距
        layout.minimumInteritemSpacing = 0.0 // item间距
        layout.itemSize = CGSize(width: 122, height: 122) // item 大小
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // section的边距
        self.photoCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.photoCollectionView.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: self.photoCollectionViewIdentifier)
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.delegate = self
        self.view.addSubview(self.photoCollectionView)
        
        self.customLayout()
        
    }
    
    func customLayout() {
        self.photoCollectionView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let cancleBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancle:")
        self.navigationItem.rightBarButtonItem = cancleBarButtonItem
        
        self.photoCollectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoGroup.photoCount
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.photoCollectionViewIdentifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
        let currentTag = cell.tag + 1
        cell.tag = currentTag
        let asset = self.photoGroup.assetsFetchResult[indexPath.item] as! PHAsset
        cell.asset = asset
        cell.index = indexPath.item
        cell.delegage = self
        let options = PHImageRequestOptions()
        options.resizeMode = .Fast
        PhotoPickerHelper.sharedInstance.photoThumbnails(asset) { (image, info) -> Void in
            if cell.tag == currentTag {
                if let tempImage = image {
                    cell.photoImageView.image = tempImage
                }
            }
        }
        
        return cell
    }
    
    // MARK: - PhotoCollectionViewCellDelegage 
    func previewAllPhotos(startIndex: Int) {
        let photoBrowserViewController = PhotoBrowserViewController()
        photoBrowserViewController.photos = self.photoGroup.assetsFetchResult.objectsAtIndexes(NSIndexSet(indexesInRange: NSRange(location:0, length:self.photoGroup.assetsFetchResult.count))) as! [PHAsset]
        photoBrowserViewController.startIndex = startIndex
        self.navigationController?.pushViewController(photoBrowserViewController, animated: true)
    }
    
    
    // MARK: - click
    func cancle(barButtonItme: UIBarButtonItem) {
        (self.navigationController as! PhotoPickerViewController).cancle()
    }
    
    // MARK: - NSNotification

}
