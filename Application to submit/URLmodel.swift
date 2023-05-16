//
//  URLmodel.swift
//  M19
//
//  Created by FILIN INTEND on 19.01.2023.
//

import UIKit

struct Model: Codable {
    public var birth: Int?
    public var occupation: String?
    public var name: String?
    public var lastName: String?
    public var country: String?
    
    enum CodingKeys: String, CodingKey {
        case birth = "Дата рождения"
        case occupation = "Занятие"
        case name = "Имя"
        case lastName = "Фамилия"
        case country = "Страна"
        
    }
    
    init() {
        self.birth = 0
        self.occupation = "undefined"
        self.name = "undefined"
        self.lastName = "undefined"
        self.country = "undefined"
    }
    
    init(birth: Int, occupation: String, name: String, lastName: String, country: String) {
        self.birth = birth
        self.occupation = occupation
        self.name = name
        self.lastName = lastName
        self.country = country
        
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        birth = try values.decodeIfPresent(Int.self, forKey: .birth)
        occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        country = try values.decodeIfPresent(String.self, forKey: .country)
    }
}
