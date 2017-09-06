//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Pavlo Kharambura on 9/6/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct Post {
    let bodyText: String!
}

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!

    static var instance = ChatViewController()
    
    var username = String()
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let database = Database.database().reference()
        database.child("Posts").child(currentUserChatID).queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            let bodyText = (snapshot.value as? NSDictionary)?["bodyText"] as? String ?? ""
            self.posts.insert(Post(bodyText: bodyText), at: 0)
            self.tableView.reloadData()
        })
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let bodyText = cell.viewWithTag(1) as! UITextView
        bodyText.text = posts[indexPath.row].bodyText
        let userNameLabel = cell.viewWithTag(2) as! UILabel
        userNameLabel.text = self.username
        
        return cell
        
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if messageTextField.text != "" {
            let uid = Auth.auth().currentUser?.uid
            let database = Database.database().reference()
            let bodyData: [String:Any] = ["uid" : uid!,
                                         "bodyText" : messageTextField.text!]
            database.child("Posts").child(currentUserChatID).childByAutoId().setValue(bodyData)
            messageTextField.text = ""
            
        }
    }

}
