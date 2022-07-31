//
//  ViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 08/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import ChameleonFramework

class ViewController: UIViewController ,NVActivityIndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(colortop: "#EF3B36", colorBottom: "#FFFFFF", self: self)
        
    }

    @IBAction func signUp(_ sender: Any) {
        progressLoading()
        
        stopAnimating()

        
    }
    
    @IBAction func SignIn(_ sender: Any) {
        progressLoading()
        
        stopAnimating()

    }

    func progressLoading(){
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.pacman, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),  textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fadeInAnimation: nil)
        
    }
  
}


