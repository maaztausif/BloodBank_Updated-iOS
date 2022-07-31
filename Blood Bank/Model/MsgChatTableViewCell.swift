//
//  MsgChatTableViewCell.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 08/05/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class MsgChatTableViewCell: UITableViewCell {
    
    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var lbl_msg: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var msgView: UIView!
    
    
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
