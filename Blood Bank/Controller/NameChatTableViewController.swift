//
//  ChatTableViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 06/05/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth 

class ChatTableViewController: UITableViewController {
    
    var userNamesArray = [String]()
    var color : String!
    var currentUserName = ""
    var dic = [String:String]()
    
    var user_ID = ""
    var otherUserName = ""
    var otherUserId = ""

    @IBOutlet var tableViewChat: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        getNameCurrentUser()
        self.color = UIColor.flatSand()?.hexValue()
        tableViewChat.register(UINib(nibName: "UserNameTableViewCell", bundle: nil), forCellReuseIdentifier: "userName")
        
        print("users dictionary : \(dic)==========================")


    }
    
    // MARK: - Table View Functions


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNamesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewChat.dequeueReusableCell(withIdentifier: "userName", for: indexPath) as! UserNameTableViewCell
        if userNamesArray[indexPath.row] == currentUserName{
          return cell
        }else{
            cell.userName.text = userNamesArray[indexPath.row]
            let colorName = UIColor(hexString: "F47C7C" )
            
            if let color = colorName?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(17)) {
                cell.backgroundColor = color
            }
            return cell
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        user_ID = Auth.auth().currentUser?.uid ?? "error"
        otherUserName = userNamesArray[indexPath.row]
        otherUserId = dic[otherUserName]!

        print("\(otherUserName)======================234")
        performSegue(withIdentifier: "goToChat", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ChatViewController
        destinationVC.currentUserName = currentUserName
        destinationVC.otherUserId = otherUserId
        destinationVC.otherUserName = otherUserName
        destinationVC.userId = user_ID
        
    }
    

    // MARK: - retrieving user name database from all user

    
    func retrieveData(){
        let database = Database.database().reference().child("All Users")
        
        database.observe(.childAdded) { (Snapshot) in
            print(Snapshot)
            let snapshotValue = Snapshot.value as! Dictionary<String,String>
            let user_ID1 = snapshotValue["userID"]!
            let userNameDB = database.database.reference().child("user: \(user_ID1)")
            userNameDB.observe(.childAdded, with: { (userSnapShot) in
                let userSnapshotValue = userSnapShot.value as! Dictionary<String,String>
                if let name = userSnapshotValue["Name"] {
                    if self.currentUserName == name{
                    }else{
                        self.dic[name] = user_ID1
                        self.userNamesArray.append(name)
                        print("users dictionary : \(self.dic)==========================")
                        self.tableViewChat.reloadData()
                    }
                }
                
                self.tableViewChat.reloadData()
                print(self.userNamesArray)

            })
            
            
            
        }

    }
    
    // MARK: - getting current user name

    
    func getNameCurrentUser(){
        print("current user name ====-=-=--")
        user_ID = Auth.auth().currentUser?.uid ?? "error"
        print(user_ID)
        let db = Database.database().reference().child("user: \(user_ID)")
        db.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            print(snapshot)
            if let currentName = snapshotValue["Name"]{
                self.currentUserName = currentName
                print(" this is current user name : \(self.currentUserName)=======================")

            }
        }
        print("current user name ====-=-=--")

    }
    


}
