//
//  CommonFunction.swift
//  Blood Bank
//
//  Created by maaz tausif on 31/07/2022.
//  Copyright © 2022 Maaz Bin Tausif. All rights reserved.
//

import Foundation
import UIKit
func setGradientBackground(colortop:String,colorBottom:String,self:UIViewController) {
    let colorTop =  UIColor.init(hexString: colortop).cgColor
    let colorBottom = UIColor.init(hexString: colorBottom).cgColor
                
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.frame = self.view.bounds
            
    self.view.layer.insertSublayer(gradientLayer, at:0)
}


import Foundation
import UIKit
func showAlert(inViewController:UIViewController,title: String, message: String, completion:@escaping()-> Void){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    showUniversalLoadingView(false, loadingText: "")
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
        completion()
    }))
    inViewController.present(alert,animated: true,completion: {})
}
func showAlert(inViewController:UIViewController,title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    showUniversalLoadingView(false, loadingText: "")
    inViewController.present(alert,animated: true,completion: nil)
}
func showUniversalLoadingView(_ show: Bool, loadingText : String = "") {
    let existingView = UIApplication.shared.windows[0].viewWithTag(1200)
    if show {
        if existingView != nil {
            return
        }
        let loadingView = makeLoadingView(withFrame: UIScreen.main.bounds, loadingText: loadingText)
        loadingView?.tag = 1200
        UIApplication.shared.windows[0].addSubview(loadingView!)
    } else {
        existingView?.removeFromSuperview()
    }

}



func makeLoadingView(withFrame frame: CGRect, loadingText text: String?) -> UIView? {
    let loadingView = UIView(frame: frame)
    loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    //activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
    activityIndicator.layer.cornerRadius = 6
    activityIndicator.center = loadingView.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .white
    activityIndicator.startAnimating()
    activityIndicator.tag = 100 // 100 for example

    loadingView.addSubview(activityIndicator)
    if !text!.isEmpty {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 80)
        lbl.center = cpoint
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.text = text
        lbl.tag = 1234
        loadingView.addSubview(lbl)
    }
    return loadingView
}
