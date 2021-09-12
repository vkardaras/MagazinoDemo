//
//  SwitchTableViewCell.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/12/21.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    static let identifier = "SwitchTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.white
        return label
    }()
    
    private let mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemGreen
        return mySwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 25/255, green: 26/255, blue: 27/255, alpha: 1)
        contentView.addSubview(label)
        contentView.addSubview(mySwitch)
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super .layoutSubviews()
        
        mySwitch.sizeToFit()
        
        mySwitch.frame = CGRect(x: contentView.frame.size.width - mySwitch.frame.size.width - 20,
                                y: (contentView.frame.size.height - mySwitch.frame.size.height)/2,
                                width: contentView.frame.size.width - 20,
                                height: contentView.frame.size.height)
        
        label.frame = CGRect(x: 15,
                             y: 0,
                             width: contentView.frame.size.width - 20,
                             height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        label.text = nil
        mySwitch.isOn = false
    }
    
    public func configure(with model: SettingSwitchOption) {
        label.text = model.title
        mySwitch.isOn = model.isOn
    }
}

