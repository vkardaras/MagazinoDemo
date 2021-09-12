//
//  Book.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/11/21.
//

struct Book {
  let id: Int
  let title: String
  let img_url: String?
  let date_released: String
  let pdf_url: String
    
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case img_url
    case date_released
    case pdf_url
  }
}

// MARK: - Decodable
extension Book: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    img_url = try container.decode(String.self, forKey: .img_url)
    date_released = try container.decode(String.self, forKey: .date_released)
    pdf_url = try container.decode(String.self, forKey: .pdf_url)
  }
}
