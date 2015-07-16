//
//  PhotoGroupTableViewCell.swift
//  PhotoPicker
//
//  Created by mxy on 15/7/14.
//  Copyright © 2015年 mxy. All rights reserved.
//

import UIKit
import SnapKit

class PhotoGroupTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        self.customLayout()
    }

    func customLayout() {
        self.imageView?.snp_makeConstraints({ (make) -> Void in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(self)
            make.width.equalTo(self.bounds.size.height)
        })
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
