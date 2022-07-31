//
//  UserNameTableViewCell.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 07/05/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class UserNameTableViewCell: UITableViewCell {
    
    @IBOutlet var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
