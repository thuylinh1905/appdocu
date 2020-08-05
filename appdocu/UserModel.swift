//
//  UserModel.swift
//  appdocu
//
//  Created by thuylinh on 7/14/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import Foundation
class UserModel {
    
    var email : String!
    var image : String!
    var phone : String!
    var status : String!
    init(email :String, image : String, phone : String, status : String ) {
        self.email = email
        self.image = image
        self.phone = phone
        self.status = status
    }
}
