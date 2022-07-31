//
//  TableViewCell.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 21/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var lbl_Name: UILabel!
    @IBOutlet var lbl_BloodType: UILabel!
    @IBOutlet var lbl_RequestFor: UILabel!
    @IBOutlet var lbl_Location: UILabel!
    @IBOutlet var txt_PhoneNo: UILabel!
    @IBOutlet var call_Btn: UIButton!
    @IBOutlet var chat_Btn: UIButton!
    
    
    var request = 1
    
    var phone_No = ""
    
    
    var userName = ""
    var userID = ""
    var otherUsername = ""
    var otherUserID = ""
    var delegate:MyCustomCellDelegatorForRequest!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_Call(_ sender: Any) {
        if let url = NSURL(string: "tel://\(phone_No)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
    }
    
  }
    
    @IBAction func btn_Chat(_ sender: Any) {
        
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.sendDataFromSegue(userName_D: userName,otherUserName_D: otherUsername,userID_D: userID,otherUserID_D: otherUserID,req:request)
            self.delegate.callSegueFromCell()
        }
        
    }
    
    func disableButtons(){
        print("bhai chala ya nai ==========\\\\\\\\\\")
        chat_Btn.isHidden = true
        call_Btn.isHidden = true
        
    }
    func enableButton(){
        print("bhai chala ya nai ////////////==========\\\\\\\\\\")
        chat_Btn.isHidden = false
        call_Btn.isHidden = false
    }

    
}
