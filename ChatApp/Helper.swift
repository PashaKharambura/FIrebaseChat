//
//  Helper.swift
//  ChatApp
//
//  Created by Pavlo Kharambura on 9/6/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    static let helper = Helper()
    
    func svitchToNavigationVC() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "profilesVC") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    
}
