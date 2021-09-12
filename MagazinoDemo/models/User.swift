//
//  User.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/11/21.
//

class User: Codable {
    // properties
    var UserName: String
    var Password: String
    
    init(withUsername: String, withPassword: String) {
        self.UserName = withUsername
        self.Password = withPassword
    }
}
