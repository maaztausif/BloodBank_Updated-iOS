//
//  SubmitRequestViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 20/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import NVActivityIndicatorView
import FirebaseAuth


class SubmitRequestViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,NVActivityIndicatorViewable{

    let pickerView = UIPickerView()
    var currentTextField: Int?
    var currentTextFieldName : UITextField!

    
    @IBOutlet var txt_Name: HoshiTextField!
    @IBOutlet var txt_BloodType: HoshiTextField!
    @IBOutlet var txt_RequestFor: HoshiTextField!
    @IBOutlet var txt_Location: HoshiTextField!
    @IBOutlet var txt_PhoneNo: HoshiTextField!
    
    let bloodTypes = ["","A+","A-","O+","O-","B+","B-","AB+","AB-"]
    let area = ["","F.B.Area","Malir","Qaidabad","Hedri","Nazimabad","ShahFaisal","Gulshan","Johar","Lyari","liaqtabad"]
    let request_For = ["Teacher","Son","Daughter","wife","Girl","Boy","Mother","Father","Collegue","Friends"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_BloodType.delegate = self
        txt_Location.delegate = self
        txt_RequestFor.delegate = self
        
        setGradientBackground(colortop: "#EF3B36", colorBottom: "#FFFFFF", self: self)

        // MARK: - For PickerView

        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
       // toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.tintColor = UIColor.black

        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txt_BloodType.inputAccessoryView = toolBar
        txt_Location.inputAccessoryView = toolBar
        txt_RequestFor.inputAccessoryView = toolBar


    }
    
    
    @objc func donePicker() {
        currentTextFieldName.resignFirstResponder()
    }
    
    // MARK: - picker View and keyboard Selection

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField.tag
        currentTextFieldName = textField
        textField.inputView = pickerView
        currentTextFieldName = textField
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == 2{
            return request_For.count
        }else if currentTextField == 3{
            return area.count
        }else if currentTextField == 1{
            return bloodTypes.count
        }
        else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == 1{
            return bloodTypes[row]
        }else if currentTextField == 2 {
            return request_For[row]
        }else if currentTextField == 3{
            return area[row]
        }else{
            return "yes"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == 1{
            txt_BloodType.text = bloodTypes[row]
        }else if currentTextField == 2 {
            txt_RequestFor.text = request_For[row]
        }else if currentTextField == 3{
            txt_Location.text = area[row]
        }
        else{
        }
    }
    
    // MARK: - Btn saving to database

    
    @IBAction func btn_Save_Request(_ sender: Any) {
        
        if txt_Name.text == "" || txt_RequestFor.text == "" || txt_Location.text == "" || txt_PhoneNo.text == "" || txt_BloodType.text == "" {
            
            let alert = UIAlertController(title: "Some Empty Field", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (aAction) in
                
            }
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
        
        }else{
            
            let userID = Auth.auth().currentUser?.uid ?? "error"

            let userDB = Database.database().reference().child("Blood Request")
            
            let Request_Dic = ["Name":txt_Name.text! ,"Blood Type":txt_BloodType.text! ,"Request For":txt_RequestFor.text! ,"Area":txt_Location.text!,"Phone No":txt_PhoneNo.text!,"User ID":userID]
            
            
            userDB.childByAutoId().setValue(Request_Dic) { (error, refrence) in
                
                if error != nil{
                    print("saving database error=================================================")
                }else{
                    print("datbase saving complete in firebase====================================")
                    
                    let alert = UIAlertController(title: "Saved Successful", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default) { (aAction) in
                        self.txt_Name.text = ""
                        self.txt_PhoneNo.text = ""
                        self.txt_Location.text = ""
                        self.txt_BloodType.text = ""
                        self.txt_RequestFor.text = ""
                        
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
