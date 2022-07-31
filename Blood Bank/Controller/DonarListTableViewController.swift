//
//  DonarListTableViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 22/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
import FirebaseAuth
import SwipeCellKit

protocol MyCustomCellDelegator {
    func callSegueFromCell()
    func sendDataFromSegue(userName_D : String,otherUserName_D:String,userID_D:String,otherUserID_D:String)
}


//,SwipeTableViewCellDelegate
class DonarListTableViewController: UITableViewController ,MyCustomCellDelegator{


    
    @IBOutlet var donarTableView: UITableView!
    
    
    var donarListArray = [Donar]()

    var color : String!
    var dic = [String:String]()
    var userReqDic = [String:String]()
    var donarID = [String]()
    
    var currentUserName_Segue = ""
    var userID_Segue = ""
    var otherUserName_Segue = ""
    var otherUserID_Segue = ""
    var donar_OtherUserID = ""
    
    var currentUserName = ""
    var userID = ""
    var otherUserName = ""
    var otherUserID = ""
    var userNamesArray = [String]()
    var donarUserID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        userID = Auth.auth().currentUser?.uid ?? "error"
        retrieveDonarLis()
        retrieveData()
        getNameCurrentUser()
        donarTableView.register(UINib(nibName: "DonarListTableViewCell", bundle: nil), forCellReuseIdentifier: "DonarCell")
        tableView.separatorStyle = .none
        
//        donarTableView.reloadData()
      //  self.donarTableView.reloadData()

        
    }
    

    
    // swipe cell
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//            // self.updateModel(at: indexPath)
//            print("delete cell")
//
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-Icon")
//
//        return [deleteAction]
//    }
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
//
//    func updateModel(at indexPath:IndexPath){
//
//    }
    
    //swipe cell kit
    
    
    // MARK: - enable swipe cell kit only for current cureent user

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if userID == userReqDic[donarListArray[indexPath.row].name]!{
            return true

        }else{
            return false

        }
    }
    
    // MARK: - Deletion of Donarcell

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            print(self.donarID[indexPath.row])

                Database.database().reference(withPath: "Donar List").child(self.donarID[indexPath.row]).removeValue()
                //self.remove(at: indexPath.row)
                self.donarListArray.remove(at: indexPath.row)
                self.donarTableView.deleteRows(at: [indexPath], with: .automatic)
                self.donarTableView.reloadData()
        }

        return [deleteAction]
    }
    
    
    
    
    
    
    func callSegueFromCell() {
        performSegue(withIdentifier: "goToChat", sender: self )
    }
    
    // MARK: - performing segue into xib chat button

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToChat"{
            
            print("from Donar UserName = \(currentUserName_Segue)")
            print("from Donar otherUserName= \(otherUserName_Segue)")
            print("from Donar UserID= \(userID_Segue)")
            print("from Donar otherUserID= \(otherUserID_Segue)")
            
            
            
            let destinationVC = segue.destination as! ChatViewController
            destinationVC.currentUserName = currentUserName_Segue
            destinationVC.otherUserId = otherUserID_Segue
            destinationVC.otherUserName = otherUserName_Segue
            destinationVC.userId = userID_Segue
        }
        
    }
    
    // MARK: - Getting data from donar list tableView

    
    func sendDataFromSegue(userName_D: String, otherUserName_D: String, userID_D: String, otherUserID_D: String) {
        
        currentUserName_Segue = userName_D
        otherUserName_Segue = otherUserName_D
        otherUserID_Segue = otherUserID_D
        userID_Segue = userID_D
        
        print("from Donar UserName = \(currentUserName_Segue)")
        print("from Donar otherUserName= \(otherUserName_Segue)")
        print("from Donar UserID= \(userID_Segue)")
        print("from Donar otherUserID= \(otherUserID_Segue)")

    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donarListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonarCell", for: indexPath) as! DonarListTableViewCell
        
                if userID == userReqDic[donarListArray[indexPath.row].name]!{
                    print("disable for user id ============p")
                     cell.disableButtons()
                }else{
                    print("enable for user id ============p")
                    cell.enableButton()
                }
        
        cell.delegate = self
        
        cell.lbl_name.text = donarListArray[indexPath.row].name
        cell.lbl_BloodType.text = donarListArray[indexPath.row].blooadType
        cell.lbl_Gender.text = donarListArray[indexPath.row].gender
        cell.lbl_LastBloodDonate.text = donarListArray[indexPath.row].lastBloodDonate
        cell.txt_phoneNo.text = donarListArray[indexPath.row].phoneNo
        cell.phone_No = donarListArray[indexPath.row].phoneNo
        
        
        cell.currentUserName = currentUserName
        cell.otherUserID = userReqDic[donarListArray[indexPath.row].name]!
        cell.OtherUserName = donarListArray[indexPath.row].name
        cell.userID = userID

        
        
        //check
        
//        cell.currentUserName = currentUserName
//        print("\(currentUserName)==================for name")
//
//        cell.userID = userID
//        cell.OtherUserName = donarListArray[indexPath.row].name
//        print("\(donarListArray[indexPath.row].name)==================In cell")
//        otherUserName = donarListArray[indexPath.row].name
//
//        print("\(otherUserName) otherUserName====================")
//
//        print("\(otherUserName)==================In cell 2 2 2")
//
//
//        if let name = dic[otherUserName]{
//            cell.otherUserID = name
//            otherUserID = name
//            print("\(name)==================In cell 2 2 2")
//        }else{
//            print("nai chala bhai ===========================")
//            let otherUserDB = Database.database().reference().child("Donar List")
//            otherUserDB.observe(.childAdded) { (userSnapshot) in
//                print("snapshot he ye : \(userSnapshot)")
//                let snapshotValue = userSnapshot.value as! Dictionary<String,String>
//
//                if self.otherUserName == self.otherUserName{
//                    print("other user name ! ========= \(snapshotValue["User ID"]!) ")
//                    cell.otherUserID = snapshotValue["User ID"]!
//                }
//            }
//        }
        
    //cell.backgroundColor = UIColor(hexString: "1D9BF6")

        let colorName = UIColor(hexString: "F47C7C" )

        if let color = colorName?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(17)) {
            cell.backgroundColor = color
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! DonarListTableViewCell
        print("\(cell.otherUserID) : otherUserID")
        print("\(cell.userID) : userID")
        print("\(cell.currentUserName) : userName")
        print("\(cell.OtherUserName) : otherUserName")
        
        
        
        print("================\\====================")
        print("\(otherUserID) : otherUserID")
        print("\(userID) : userID")
        print("\(currentUserName) : userName")
        print("\(otherUserName) : otherUserName")
        donarTableView.reloadData()
   
    }
    
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        print("bhai will select row at chala he ==================")
//    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    
    func retrieveData(){
        
//        print("retrieve data he =================")
//        let database = Database.database().reference().child("All Users")
//
//        database.observe(.childAdded) { (Snapshot) in
//            let snapshotValue = Snapshot.value as! Dictionary<String,String>
//            let user_ID1 = snapshotValue["userID"]!
//            print("\(user_ID1)=============43")
//            let userNameDB = database.database.reference().child("user: \(user_ID1)")
//
//            userNameDB.observe(.childAdded, with: { (userSnapShot) in
//                print(userSnapShot)
//                let userSnapshotValue = userSnapShot.value as! Dictionary<String,String>
//                if let name = userSnapshotValue["Name"] {
//                    if self.currentUserName == name{
//                    }else{
//                        self.dic[name] = user_ID1
//                        self.userNamesArray.append(name)
//                        print("users dictionary : \(self.dic)==========================")
//                        self.donarTableView.reloadData()
//
//                    }
//                }
//
//                print(self.userNamesArray)
//
//            })
//
//
//
//
//        }
        
    }
    
    // MARK: - retrieving donar data fuction


    func retrieveDonarLis(){
        let donarDB = Database.database().reference().child("Donar List")
        donarDB.observe(.childAdded) { (Snapshot) in
            let snapshotValue = Snapshot.value as! Dictionary<String,String>
            let user_Donar = Donar()
            user_Donar.name = snapshotValue["Name"]!
            user_Donar.gender = snapshotValue["Gender"]!
            user_Donar.blooadType = snapshotValue["Blood Type"]!
            user_Donar.lastBloodDonate = snapshotValue["Last Blood Donate"]!
            user_Donar.phoneNo = snapshotValue["Phone No"]!
            self.userReqDic[snapshotValue["Name"]!] = snapshotValue["User ID"]!
            print("\(self.userReqDic) userDic =================")
            self.donarUserID = snapshotValue["User ID"]!
            self.color = UIColor.flatSand()?.hexValue()
            self.donarListArray.append(user_Donar)
            self.donarTableView.reloadData()
            
        }
        
        //            Database.database().reference().child("Donar List").observeSingleEvent(of: .value, with: { (snapshot) in
        //                print("\(snapshot) snap shot he ye")
        //                for snap in snapshot.children {
        //                    let userSnap = snap as! DataSnapshot
        //                    let uid1 = userSnap.key //the uid of each user
        //                    print("\(uid1) user keys")
        //                })
        
        // MARK: - getting ChildAutoID() of donarList Database

        
        Database.database().reference().child("Donar List").observeSingleEvent(of: .value) { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let uid1 = userSnap.key //the uid of each user
                print("\(uid1) user keys")
                self.donarID.append(uid1)

             }
        }
        
        self.donarTableView.reloadData()

    }
    
    // MARK: - getting Current user name

    
    func getNameCurrentUser(){
        let userID = Auth.auth().currentUser?.uid ?? "error"
        let db = Database.database().reference().child("user: \(userID)")
        db.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            if let currentName = snapshotValue["Name"]{
                self.currentUserName = currentName
                print(" this is current user name : \(self.currentUserName)=======================")
            }
            
        }
        
    }
    
}
