    //
//  petDetailCell.swift
//  魔靈資訊
//
//  Created by CK Lam on 26/10/14.
//  Copyright (c) 2014 CK Lam. All rights reserved.
//

import UIKit

class petDetailCell: UITableViewCell {

    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var skillContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
