//
//  InfoViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 11/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import NVActivityIndicatorView
import ChameleonFramework
import FirebaseAuth


class InfoViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,NVActivityIndicatorViewable {
    
    var user_Id = ""

    
    @IBOutlet var txt_Name: HoshiTextField!
    @IBOutlet var txt_PhoneNo: HoshiTextField!
    @IBOutlet var txt_Email: HoshiTextField!
    @IBOutlet var txt_BloodType: HoshiTextField!
    @IBOutlet var txt_Gender: HoshiTextField!
    @IBOutlet var txt_DOB: HoshiTextField!
    @IBOutlet var txt_lastBD: HoshiTextField!
    @IBOutlet var txt_Area: HoshiTextField!
    @IBOutlet var txt_Disease: HoshiTextField!
    
    @IBOutlet var btn_Main: UIButton!
    
    let pickerView = UIPickerView()

    var currentTextField: Int?
    var currentTextFieldName : UITextField!
    
    let bloodTypes = ["","A+","A-","O+","O-","B+","B-","AB+","AB-"]
    let gender = ["","Male","Female","Unspecified"]
    let area = ["","F.B.Area","Malir","Qaidabad","Hedri","Nazimabad","ShahFaisal","Gulshan","Johar","Lyari","liaqtabad"]
    let last_Blood_Donate = ["","never","1 month","2 month","3 month","4 month","5 month","6 month","7 month","8 month","9 month","10 month","1 Year"]
    let blood_Disease = ["","None","Asthama","pta nahi bhai"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(colortop: "#EF3B36", colorBottom: "#FFFFFF", self: self)

        btn_Main.layer.cornerRadius = 20
        btn_Main.clipsToBounds = true
    
        
//        pickerView.delegate = self
//        pickerView.dataSource = self
        
        txt_BloodType.delegate = self
        txt_Gender.delegate = self
        txt_Area.delegate = self
        txt_Disease.delegate = self
        txt_lastBD.delegate = self
        
        //MARK: Picker view Ok And cancel Button
        
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
        
        txt_Gender.inputAccessoryView = toolBar
        txt_BloodType.inputAccessoryView = toolBar
        txt_Area.inputAccessoryView = toolBar
        txt_Disease.inputAccessoryView = toolBar
        txt_lastBD.inputAccessoryView = toolBar

    }
    
   
    // MARK: - picker View and keyboard Selection

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField.tag
        currentTextFieldName = textField
        textField.inputView = pickerView
    }
    
    // MARK: - pickerView functions

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == 1{
            return bloodTypes.count
        }else if currentTextField == 2{
            return gender.count
        }else if currentTextField == 4{
            return last_Blood_Donate.count
        }else if currentTextField == 5{
            return area.count
        }else if currentTextField == 6{
            return blood_Disease.count
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == 1{
            return bloodTypes[row]
        }else if currentTextField == 2 {
            return gender[row]
        }else if currentTextField == 4{
            return last_Blood_Donate[row]
        }else if currentTextField == 5{
            return area[row]
        }else if currentTextField == 6{
            return blood_Disease[row]
        }
        else{
            print("\(currentTextField)========================================================")
            return "yes"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == 1{
            txt_BloodType.text = bloodTypes[row]
        }else if currentTextField == 2 {
            txt_Gender.text = gender[row]
        }else if currentTextField == 4{
            txt_lastBD.text = last_Blood_Donate[row]
        }else if currentTextField == 5{
            txt_Area.text = area[row]
        }else if currentTextField == 6{
            txt_Disease.text = blood_Disease[row]

        }
        else{
        }
    }
    
    
    @objc func donePicker() {
        currentTextFieldName.resignFirstResponder()
    }
    
    // MARK: - btn saving data into 


    @IBAction func btn_Send_ToMain(_ sender: Any) {
        progressLoading()
        
        if txt_Gender.text == "" || txt_Disease.text == "" || txt_lastBD.text == "" || txt_Area.text == "" || txt_DOB.text == "" || txt_Name.text == "" || txt_Email.text == "" || txt_PhoneNo.text == "" || txt_BloodType.text == ""{
            self.stopAnimating()
            print("some field is missing=====================================")
            
        }else{
            
            let userID = Auth.auth().currentUser?.uid ?? "error"
            
            let userDB = Database.database().reference().child("user: \(userID)").childByAutoId()
            print("\(user_Id)==========================================================")
            
            let userDic = ["Name":txt_Name.text!,"Email":txt_Email.text!,"Phone No":txt_PhoneNo.text!,"Blood Type":txt_BloodType.text!,"Gender":txt_Gender.text!,"Area":txt_Area.text!,"Date Of Birth":txt_DOB.text!,"Last Blood Donate":txt_lastBD.text!,"Blood disease":txt_Disease.text!]
            
            userDB.setValue(userDic) { (error, refrence) in
                if error != nil{
                    self.stopAnimating()
                    print("saving database error=================================================")
                }else{
                    print("datbase saving complete in firebase====================================")
                    self.stopAnimating()
                    self.performSegue(withIdentifier: "goToMain", sender: self)
                }
            }

        }
    }
    
    
    func progressLoading(){
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.pacman, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),  textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fadeInAnimation: nil)
        
    }
    
 }

