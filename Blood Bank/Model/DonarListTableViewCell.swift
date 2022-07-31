//
//  DonarListTableViewCell.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 22/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class DonarListTableViewCell: UITableViewCell,UITableViewDelegate{

    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var lbl_Gender: UILabel!
    @IBOutlet var lbl_BloodType: UILabel!
    @IBOutlet var lbl_LastBloodDonate: UILabel!
    @IBOutlet var txt_phoneNo: UILabel!
    @IBOutlet var chat_Btn: UIButton!
    @IBOutlet var call_Btn: UIButton!
    
    var phone_No = ""
    var currentUserName = ""
    var userID = ""
    var otherUserID = ""
    var OtherUserName = ""
    var delegate:MyCustomCellDelegator!

    
    
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
            UIApplication.shared.openURL(url as URL)    }
    }
    
    @IBAction func btn_Chat(_ sender: Any) {
        
        print("\(currentUserName)==========")
        print("(\(userID)===========")
        print("\(otherUserID)=============")
        print("\(OtherUserName)============")
        
        //var mydata = "Anydata you want to send to the next controller
            if(self.delegate != nil){ //Just to be safe.
                self.delegate.sendDataFromSegue(userName_D: currentUserName,otherUserName_D: OtherUserName,userID_D: userID,otherUserID_D: otherUserID)
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
