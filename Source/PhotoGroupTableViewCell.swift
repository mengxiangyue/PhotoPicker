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
    
    var groupImageView: UIImageView!
    var groupNameLable: UILabel!
    var bottomLineView: UIView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        // Cell选中的颜色
//        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.groupImageView = UIImageView()
        self.groupImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.addSubview(groupImageView)
        
        self.groupNameLable = UILabel()
        self.addSubview(self.groupNameLable)
        
        self.bottomLineView = UIView()
        self.bottomLineView.backgroundColor = UIColor.grayColor()
        self.bottomLineView.alpha = 0.3
        self.addSubview(self.bottomLineView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.customLayout()
    }

    func customLayout() {
        self.groupImageView.snp_makeConstraints({ (make) -> Void in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(self)
            make.width.equalTo(self.bounds.size.height)
            make.right.equalTo(self.groupNameLable.snp_left).offset(-20)
            print(self.bounds.size.height)
        })
        
        self.groupNameLable.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.left.equalTo(self.groupImageView.snp_right).offset(20)
            make.right.equalTo(self).offset(-50)
        }
        
        self.bottomLineView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
