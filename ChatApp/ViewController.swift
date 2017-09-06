//
//  ViewController.swift
//  ChatApp
//
//  Created by Pavlo Kharambura on 9/5/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore

class ViewController: UIViewController {
    @IBOutlet weak var usernameTeztField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAction(_ sender: Any) {
        login()
    }
 
    @IBAction func registerAction(_ sender: Any) {
        register()
    }

    func login() {
        if usernameTeztField.text != "" && emailTextField.text != "" && passTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passTextField.text!, completion: { (user, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    Helper.helper.svitchToNavigationVC()
                    ChatViewController.instance.username = self.usernameTeztField.text!
                }
            })
        } else {
            // smth alert
        }
        
        
    }
    
    func register() {
        if usernameTeztField.text != "" && emailTextField.text != "" && passTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passTextField.text!, completion: { (user, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    let uid = Auth.auth().currentUser?.uid
                    let databaseRef = Database.database().reference()
                    let userData: [String:Any] = ["email" : self.emailTextField.text!,
                                                  "uid" : uid!,
                                                  "username" : self.usernameTeztField.text!]
                    databaseRef.child("Users").child(uid!).setValue(userData)
                    Helper.helper.svitchToNavigationVC()
                    ChatViewController.instance.username = self.usernameTeztField.text!

                }
            })
        } else {
            
        }
        
    }
    
}

