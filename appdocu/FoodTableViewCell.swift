//
//  FoodTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/3/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var tenmon : UILabel!
    
    func truyenve(loaimon1 : loaimon) {
        self.layoutSubviews()
        tenmon.text = loaimon1.ten
        if let profileimage = loaimon1.hinhanh {
            if let url = URL(string: profileimage){
                print(url)
                KingfisherManager.shared.retrieveImage(with: url as! Resource, options: nil, progressBlock: nil) { (image, error, cache, imageurl) in
                    self.imageview.image = image
                }
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
     
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
