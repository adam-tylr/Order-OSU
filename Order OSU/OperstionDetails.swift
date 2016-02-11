//
//  opDetails.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/5/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit

class OperationDetails{
    var photo: UIImage?
    var msg: String
    var hours: String
    
    init?(photo: UIImage, msg: String, hours: String){
        self.photo = photo
        self.msg = msg
        self.hours = hours
    }
}
