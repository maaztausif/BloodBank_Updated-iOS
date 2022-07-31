//
//  UserInfoViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 18/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class UserInfoViewController: UIViewController {
    
    
    var value:Bool = false
   // let ref: DatabaseReference!
    let ref = Database.database().reference()
    
    @IBOutlet var txt_Name: UITextField!
    @IBOutlet var txt_PhoneNo: UITextField!
    @IBOutlet var txt_Email: UITextField!
    @IBOutlet var txt_BloodType: UITextField!
    @IBOutlet var txt_Gender: UITextField!
    @IBOutlet var txt_DOB: UITextField!
    @IBOutlet var txt_lastBD: UITextField!
    @IBOutlet var txt_Area: UITextField!
    @IBOutlet var txt_Disease: UITextField!
    var viewArray:[UIView] = []
    var user_Id = ""
    var childID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewArray.append(txt_Name)
        viewArray.append(txt_PhoneNo)
        viewArray.append(txt_Email)
        viewArray.append(txt_BloodType)
        viewArray.append(txt_Gender)
        viewArray.append(txt_DOB)
        viewArray.append(txt_lastBD)
        viewArray.append(txt_Area)
        viewArray.append(txt_Disease)
        retrieveUserData()
        setGradientBackground(colortop: "#EF3B36", colorBottom: "#FFFFFF", self: self)
    }
    
    // MARK: - Retrieving data from Database

    
    func retrieveUserData(){
        
        
        let userID = Auth.auth().currentUser?.uid ?? "error"
        
        print("\(userID)==========================================================hoko")
        let userDatabase = Database.database().reference().child("user: \(userID)")
        userDatabase.observe(.childAdded) { (snapshot) in
            print(snapshot)
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            self.txt_Name.text = snapshotValue["Name"]!
            self.txt_PhoneNo.text = snapshotValue["Phone No"]!
            self.txt_Email.text = snapshotValue["Email"]!
            self.txt_BloodType.text = snapshotValue["Blood Type"]!
            self.txt_Gender.text = snapshotValue["Gender"]!
            self.txt_DOB.text = snapshotValue["Date Of Birth"]!
            self.txt_lastBD.text = snapshotValue["Last Blood Donate"]!
            self.txt_Area.text = snapshotValue["Area"]!
            self.txt_Disease.text = snapshotValue["Blood disease"]!
            
        }
        print("\(userID)==========================================================hoko")
        
                Database.database().reference().child("user: \(userID)").observeSingleEvent(of: .value) { (snapshot) in
                    for snap in snapshot.children {
                        let userSnap = snap as! DataSnapshot
                        self.childID = userSnap.key //the uid of each user
                        print("\(self.childID) user keys")
                    }
                }
        
        
 
    }
    
    // MARK: - update Button

    
    @IBAction func update(_ sender: Any) {
        viewArray.append(txt_Name)
        viewArray.append(txt_PhoneNo)
        viewArray.append(txt_Email)
        viewArray.append(txt_BloodType)
        viewArray.append(txt_Gender)
        viewArray.append(txt_DOB)
        viewArray.append(txt_lastBD)
        viewArray.append(txt_Area)
        viewArray.append(txt_Disease)

        if txt_Name.text == "" || txt_PhoneNo.text == "" || txt_Email.text == "" || txt_BloodType.text == "" || txt_Gender.text == "" || txt_DOB.text == "" || txt_lastBD.text == "" || txt_Area.text == "" || txt_Disease.text == ""{
            showAlert(inViewController: self, title: "Alert!", message: "Empty Field")
        }else{
            let userDic = ["Name":txt_Name.text!,"Email":txt_Email.text!,"Phone No":txt_PhoneNo.text!,"Blood Type":txt_BloodType.text!,"Gender":txt_Gender.text!,"Area":txt_Area.text!,"Date Of Birth":txt_DOB.text!,"Last Blood Donate":txt_lastBD.text!,"Blood disease":txt_Disease.text!]
            
            print(userDic)
            let userID = Auth.auth().currentUser?.uid ?? "error"
            

            let ref = Database.database().reference().root.child("user: \(userID)").childByAutoId().updateChildValues(userDic) { (error, refrence) in
                if error != nil{
                    print("updating error")
                    
                    let alert = UIAlertController(title: "Error In Update", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        
                    })
                    
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                    
                    
                }else{
                    print("no error in update")
                    
                    let alert = UIAlertController(title: "Update Complete", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        
                    })
                    
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                    
                    
                }
            }

            Database.database().reference(withPath: "user: \(userID)").child(self.childID).removeValue()

            
            
           retrieveUserData()
        }
        

        
    }
    

}
