//
//  TableViewController.swift
//  ChatApp
//
//  Created by Pavlo Kharambura on 9/6/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct User {
    let userName: String!
    let uid: String!
}

var currentUserChatID = String()

class TableViewController: UITableViewController {

    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let database = Database.database().reference()
        database.child("Users").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            let username = (snapshot.value as? NSDictionary)?["username"] as? String ?? ""
            let uid = (snapshot.value as? NSDictionary)?["uid"] as? String ?? ""
            self.users.append(User(userName: username, uid: uid))
            self.tableView.reloadData()
        })
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentUserChatID = users[indexPath.row].uid
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let userNameLabel = cell.viewWithTag(1) as! UILabel
        userNameLabel.text = users[indexPath.row].userName
        
        
        return cell
    }
 

}
