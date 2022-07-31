//
//  MainScreenViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 18/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseAuth


class MainScreenViewController: UIViewController {
    
    @IBOutlet var btn_UserInfo: UIButton!
    @IBOutlet var btn_BloodInfo: UIButton!
    @IBOutlet var btn_bloodRequest: UIButton!
    @IBOutlet var btn_donarRequest: UIButton!
    @IBOutlet var btn_Chat: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(colortop: "#EF3B36", colorBottom: "#FFFFFF", self: self)
        navigationController?.isToolbarHidden = true
//      btn_UserInfo.backgroundColor = UIColor.flatCoffee()
 //       btn_bloodRequest.backgroundColor = UIColor.flatCoffee()
 //       btn_donarRequest.backgroundColor = UIColor.flatCoffee()
  //      btn_BloodInfo.backgroundColor = UIColor.flatCoffee()
   //     btn_Chat.backgroundColor = UIColor.flatCoffee()
        

    }
    
    @IBAction func btn_call(_ sender: Any) {
  

        
    }
    
    @IBAction func btn_signout(_ sender: Any) {
        
        let signOut = Auth.auth()
        do {
            try signOut.signOut()
        } catch let signOutError as NSError {
            print("SignOut error======================")
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    }
    

