//
//  SettingsViewController.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/12/21.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingOptionType]
}

enum SettingOptionType {
    case staticCell(model: SettingOption)
    case switchCell(model: SettingSwitchOption)
}

struct SettingSwitchOption {
    let title: String
    var isOn: Bool
    let handler: (() -> Void)
}

struct SettingOption {
    let title: String
    var showIndicator: Bool
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor(red: 25/255, green: 26/255, blue: 27/255, alpha: 1)
            tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
            tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        }
     }
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title  = "Ρυθμίσεις"
    }
    
    func configure() {
        models.append(Section(title: "General", options: [
            .switchCell(model: SettingSwitchOption(title: "Ειδοποιήσεις", isOn: true) {
                print("Tapped first cell")
            }),
            .staticCell(model: SettingOption(title: "Διαγραφή όλων των περιοδικών", showIndicator: false) {
                print("Tapped first cell")
            }),
            .staticCell(model: SettingOption(title: "Γλώσσα", showIndicator: true) {
                
            }),
            .staticCell(model: SettingOption(title: "Feedback", showIndicator: true) {
                
            }),
            .staticCell(model: SettingOption(title: "Αποσύνδεση", showIndicator: false) {
                UserDefaults.standard.removeObject(forKey: "access_token")
                UserDefaults.standard.removeObject(forKey: "refresh_token")
                
                
                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

                let customViewControllersArray : NSArray = [newViewController]
                self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                self.navigationController?.popToRootViewController(animated: true)
            })
        ]))
    }

}
extension SettingsViewController: UITableViewDataSource , UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let section = models[section]
//        return section.title
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
    }
    
}
