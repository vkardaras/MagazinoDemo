//
//  StartViewController.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/11/21.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let access_token = UserDefaults.standard.string(forKey: "access_token")
        print(access_token ?? "")
        
        if access_token == nil {
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            })
        } else {
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "mainSegue", sender: nil)
            })
        }
    }

}
