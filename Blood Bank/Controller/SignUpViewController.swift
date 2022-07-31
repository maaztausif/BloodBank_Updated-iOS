//
//  SignUpViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 10/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import NVActivityIndicatorView
import FirebaseAuth


class SignUpViewController: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet var txt_Email: HoshiTextField!
    
    @IBOutlet var txt_Password: HoshiTextField!
    
    @IBOutlet var btn_signUp: UIButton!
    
//    @IBOutlet var txt_Name: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(colortop: "#EF3B36", colorBottom: "#FFFFFF", self: self)

        btn_signUp.layer.cornerRadius = 20
        btn_signUp.clipsToBounds = true
    }
    
    // MARK: - SignUp Button

    
    @IBAction func signUp_btn(_ sender: Any) {
        
        if txt_Email.text == "" || txt_Password.text == ""{
            
            let alert = UIAlertController(title: "Some Empty Field", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (aAction) in
                
            }
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
            
            
        }else{
            progressLoading()
            
            Auth.auth().createUser(withEmail: txt_Email.text!, password: txt_Password.text!) { (user, error) in
                if error != nil{
                    print("error creating user======================================")
                    self.stopAnimating()
                    
                    
                    let alert = UIAlertController(title: "Some Empty Field", message: "\(error)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default) { (aAction) in
                        
                    }
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                    
                    
                }else{
                    print("creature suer Succesful==================================")           
                    let db = Database.database().reference().child("All Users")
                    let userID = Auth.auth().currentUser?.uid ?? "error"
                    let userDic = ["userID":"\(userID)"]
                    
                    db.childByAutoId().setValue(userDic) { (error, refrence) in
                        if error != nil{
                            print("Error In Saving database======================================Donar database")
                        }else{
                            print("Complete Saving database======================================Donar database")
                            
                        }
                    }
                    
                    self.stopAnimating()
                    self.txt_Password.text = ""
                    self.txt_Email.text = ""
                    self.performSegue(withIdentifier: "goToInfo", sender: self)
                    
                }
            }
            
        }

    }
    
    // MARK: - From Segue to send value to other view controller

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InfoViewController
        vc.user_Id = txt_Email.text! 
    }
  
    func progressLoading(){
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.pacman, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),  textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fadeInAnimation: nil)
        
    }
    
}
