//
//  MiscViewController.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/12/21.
//

import UIKit

class MiscViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title  = "Διάφορα"
    }

}
