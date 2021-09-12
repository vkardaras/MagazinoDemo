//
//  LoginViewController.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField! {
        didSet {
           userTextField.tintColor = UIColor.lightGray
           userTextField.backgroundColor = UIColor.white
            userTextField.text = "TH1234"
        }
     }
    
    @IBOutlet weak var passTextField: UITextField! {
        didSet {
           passTextField.tintColor = UIColor.lightGray
           passTextField.backgroundColor = UIColor.white
            passTextField.text = "3NItas1!"
        }
     }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = loginButton.frame.size.height/2
            loginButton.layer.borderWidth = 1
            loginButton.tintColor = UIColor.green
            loginButton.layer.borderColor = UIColor.green.cgColor
            loginButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func infoAction(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "τουλάχιστον 8 χαρακτήρες (2 κεφαλαία, 3 πεζά, 1 ειδικός χαρακτήρας, 2 νούμερα)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Επιστροφή", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func loginAction(_ sender: Any) {
        
        let user = User(withUsername: userTextField.text ?? "", withPassword: passTextField.text ?? "")
        ApiManager.shared.login(user: user) { response in
            debugPrint("response = \(response)")
            
            switch response.response?.statusCode {
            case 200:
                guard let loginResponse = response.value else {
                    debugPrint(response)
                    return
                }
                if response.response?.statusCode == 200 {
                    self.saveToken(response: loginResponse)
                }
            default:
                let alert = UIAlertController(title: "Λανθασμένα στοιχεία", message: "Έχετε υποβάλει λάθος στοιχεία.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Επιστροφή", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    func saveToken(response: LoginResponse) {
        
        let refresh_token = response.refresh_token
        let access_token = response.access_token
        
        if refresh_token != "" {
            UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
        }
        if access_token != "" {
            UserDefaults.standard.set(access_token, forKey: "access_token")
        }
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "mainSegue", sender: nil)
        })
    }

}
