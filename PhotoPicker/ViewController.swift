//
//  ViewController.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import PhotoPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "rightButtonClick:")
        self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
        
    }

    func rightButtonClick(buttonItem: UIBarButtonItem) {
        let photoPickerViewController = PhotoPickerViewController()
        self.presentViewController(photoPickerViewController, animated: true, completion: nil)
    }


}

