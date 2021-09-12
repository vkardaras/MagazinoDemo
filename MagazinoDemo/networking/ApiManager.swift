//
//  ApiManager.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/11/21.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    fileprivate let baseUrlString = "https://3nt-demo-backend.azurewebsites.net/Access"
    
    func apiHeaders() -> HTTPHeaders{
        
        let tokenValue = UserDefaults.standard.string(forKey: "access_token")
        print(tokenValue ?? "")
        let headers: HTTPHeaders = [.authorization(bearerToken: tokenValue ?? "")]
        return headers
    }
    
    func login(user: User, completion: @escaping (DataResponse<LoginResponse, AFError>) -> Void) {
        
        debugPrint(user)
        AF.request(baseUrlString+"/Login", method: .post, parameters: user)
            .responseDecodable(of: LoginResponse.self) { response in
              completion(response)
          }
    }
    
    func getBooks(completion: @escaping ([Book]) -> Void) {
      let url = baseUrlString+"/Books"
      AF.request(url, headers:self.apiHeaders())
          .responseDecodable(of: [Book].self) { response in
              debugPrint(response)
              guard let items = response.value else {
                  return completion([])
              }
            completion(items)
        }
    }
}
