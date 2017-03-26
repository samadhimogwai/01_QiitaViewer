//
//  CustomTableViewCell.swift
//  QiitaViewer
//
//  Created by Hitomi Mikuni on 2017/03/25.
//  Copyright © 2017年 Hitomi Mikuni. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK:Variable
    var listUrl: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Customize imageView
        self.imageView?.frame = CGRect(x: 10,y: 0, width: 40, height: 40)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        // Costomize textlabel
        self.textLabel?.frame = CGRect(x: 60, y: 0, width: self.frame.width - 45, height: 20)
        self.detailTextLabel?.frame = CGRect(x: 60, y: 20, width: self.frame.width - 45, height: 15)
    }

}
