//
//  SettingTableViewCell.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/12/21.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    static let identifier = "SettingTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.superview!.backgroundColor = UIColor(red: 25/255, green: 26/255, blue: 27/255, alpha: 1)
        contentView.superview!.tintColor = .systemGreen
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super .layoutSubviews()
        
        label.frame = CGRect(x: 15,
                             y: 0,
                             width: contentView.frame.size.width - 20,
                             height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        label.text = nil
    }
    
    public func configure(with model: SettingOption) {
        label.text = model.title
        if model.showIndicator == true {
            accessoryType = .disclosureIndicator
            
            let chevron = UIImage(named: "arrow_right")
            accessoryView = UIImageView(image: chevron!)
        }
    }
}
