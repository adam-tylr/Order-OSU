//
//  OperationTableViewCell.swift
//  Order OSU
//
//  Created by Adam Tyler on 2/5/16.
//  Copyright © 2016 Adam Tyler. All rights reserved.
//

import UIKit

class OperationTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
