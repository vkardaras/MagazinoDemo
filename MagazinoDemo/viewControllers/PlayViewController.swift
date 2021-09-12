//
//  PlayViewController.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/12/21.
//

import UIKit

class PlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title  = "Ανάγνωση"
    }
}
