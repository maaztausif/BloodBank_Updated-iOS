//
//  SignInViewController.swift
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


class SignInViewController: UIViewController ,NVActivityIndicatorViewable{
    @IBOutlet var txt_Email: HoshiTextField!
    @IBOutlet var txt_Password: HoshiTextField!
    @IBOutlet var btn_SignIn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(colortop: "#EF3B36", colorBottom: "#FFFFFF", self: self)
        btn_SignIn.layer.cornerRadius = 20
        btn_SignIn.clipsToBounds = true

    }
    
    // MARK: - SignIn Button

    
    @IBAction func signIn_Btn(_ sender: Any) {
        if txt_Email.text == "" || txt_Password.text == ""{
            
            let alert = UIAlertController(title: "Some Empty Field", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (aAction) in
                
            }
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
            
        }else{
            progressLoading()
            Auth.auth().signIn(withEmail: txt_Email.text!, password: txt_Password.text!) { (auth, error) in
                if error != nil{
                    self.stopAnimating()
                    print("error sign in")
                }else{
                    print("SignIn successful")
                    self.stopAnimating()
                    self.txt_Email.text = ""
                    self.txt_Password.text = ""
                    self.performSegue(withIdentifier: "goToMain", sender: self)
                }
            }
            
        }
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! UserInfoViewController
//        vc.user_Id = txt_Email.text!
    }
    
    
    
    func progressLoading(){
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.pacman, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),  textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fadeInAnimation: nil)
        
    }

}
