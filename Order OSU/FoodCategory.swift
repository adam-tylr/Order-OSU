//
//  Category.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/6/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit

class FoodCategory {
    var name: String
    var photo: UIImage?
    var link: String
    
    init?(name:String, photo: UIImage, link: String){
        self.name = name
        self.photo = photo
        self.link = link
    }
}
