//
//  SubmitDonarViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 22/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import NVActivityIndicatorView
import ChameleonFramework
import FirebaseAuth



class SubmitDonarViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,NVActivityIndicatorViewable {

    var currentTextField : Int!
    let pickerView = UIPickerView()
    var currentTextFieldName : UITextField!
    var user_ID = ""

    
    @IBOutlet var txt_Name: HoshiTextField!
    @IBOutlet var txt_Gender: HoshiTextField!
    @IBOutlet var txt_BloodType: HoshiTextField!
    @IBOutlet var txt_LastBloodDonate: HoshiTextField!
    @IBOutlet var txt_phoneNo: HoshiTextField!
    
    
    let bloodTypes = ["","A+","A-","O+","O-","B+","B-","AB+","AB-"]
    let gender = ["","Male","Female","Unspecified"]
    let last_Blood_Donate = ["","never","1 month","2 month","3 month","4 month","5 month","6 month","7 month","8 month","9 month","10 month","1 Year"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_Gender.delegate = self
        txt_BloodType.delegate = self
        txt_LastBloodDonate.delegate =  self
        
        user_ID = Auth.auth().currentUser?.uid ?? "error"
        
        setGradientBackground(colortop: "#EF3B36", colorBottom: "#FFFFFF", self: self)

        // MARK: - Ok and Canceel Button in pickerView

        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.tintColor = UIColor.black

        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txt_Gender.inputAccessoryView = toolBar
        txt_BloodType.inputAccessoryView = toolBar
        txt_LastBloodDonate.inputAccessoryView = toolBar

    }
    

    @objc func donePicker() {
        currentTextFieldName.resignFirstResponder()
    }
    
    // MARK: - picker View and keyboard Selection

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField.tag
        textField.inputView = pickerView
        currentTextFieldName = textField
    }
    
    // MARK: - picker View functions

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == 1{
            return gender.count
        }else if currentTextField == 2{
            return bloodTypes.count
        }else{
            return last_Blood_Donate.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == 1{
            return gender[row]
        }else if currentTextField == 2{
            return bloodTypes[row]
        }else{
            return last_Blood_Donate[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == 1{
             txt_Gender.text = gender[row]
        }else if currentTextField == 2{
            txt_BloodType.text = bloodTypes[row]
        }else{
             txt_LastBloodDonate.text = last_Blood_Donate[row]
        }
    }

    // MARK: - btn Submit for donar data into database

    
    @IBAction func submitDonation(_ sender: Any) {
        if txt_Name.text == "" || txt_Gender.text == "" || txt_BloodType.text == ""  || txt_LastBloodDonate.text == "" || txt_phoneNo.text == ""{
            
            let alert = UIAlertController(title: "Some Empty Field", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (aAction) in
                
            }
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
            
        }else{
            let donarDB = Database.database().reference().child("Donar List")
            let donarDic = ["Name":txt_Name.text!,"Gender":txt_Gender.text!,"Blood Type":txt_BloodType.text!,"Last Blood Donate":txt_LastBloodDonate.text!,"Phone No":txt_phoneNo.text!,"User ID": user_ID]
            
            donarDB.childByAutoId().setValue(donarDic) { (error, refrence) in
                if error != nil{         
                    print("Error In Saving database======================================Donar database")
                }else{
                    print("Complete Saving database======================================Donar database")
                    
                    let alert = UIAlertController(title: "Saved Successful", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default) { (aAction) in
                        self.txt_Name.text = ""
                        self.txt_phoneNo.text = ""
                        self.txt_Gender.text = ""
                        self.txt_BloodType.text = ""
                        self.txt_LastBloodDonate.text = ""
                        
//                        if(self.delegate != nil){ //Just to be safe.
//                            self.delegate.callSegue()
//                        }else{
//                            print("call segue nil he bhai===================")
//                        }
                        
                        self.navigationController?.popViewController(animated: true)

                        
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                }
            }
        }
        

    }
    
    func progressLoading(){
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.pacman, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),  textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fadeInAnimation: nil)
        
    }

}
