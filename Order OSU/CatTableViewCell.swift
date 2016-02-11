//
//  CatTableViewCell.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/6/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
