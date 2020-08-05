//
//  ProfileTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 7/14/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var txtemail: UILabel!
    @IBOutlet weak var txtphone: UILabel!
    @IBOutlet weak var txtimage: UILabel!
    @IBOutlet weak var txtstatus: UILabel!
    
    func truyencell(usmodel : UserModel) {
        txtemail.text = usmodel.email
        txtimage.text = usmodel.image
        txtphone.text = usmodel.phone
        txtstatus.text = usmodel.status
    }
}
