//
//  LoginResponse.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/11/21.
//

struct LoginResponse: Decodable {
    // properties
    var expires_in: Int
    var token_type: String
    var refresh_token: String
    var access_token: String
}
