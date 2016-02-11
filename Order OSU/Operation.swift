//
//  Operation.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/5/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit

class Operation{
    var name: String
    var photo: UIImage?
    
    init?(name: String, photo: UIImage){
        self.name = name
        self.photo = photo
    }
}
