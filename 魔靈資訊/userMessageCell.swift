//
//  userMessageCell.swift
//  魔靈資訊
//
//  Created by CK Lam on 4/11/14.
//  Copyright (c) 2014 CK Lam. All rights reserved.
//

import UIKit

class userMessageCell: UITableViewCell {

    @IBOutlet weak var userPet: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMessageContent: UILabel!
    
    var TotalMessageCount = 0;
    
    var countMe : [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
