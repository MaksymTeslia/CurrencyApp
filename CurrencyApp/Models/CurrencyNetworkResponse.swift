//
//  NetworkResponse.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 23.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import Foundation

private enum CodingKeys: String, CodingKey {
    case rate
    case cc
    case r030
    case txt
}

class CurrencyInfo: Decodable {
    var identifier: Int
    var name: String
    var rate: Double
    var currencyCode: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(Int.self, forKey: .r030)
        name = try container.decode(String.self, forKey: .txt)
        currencyCode = try container.decode(String.self, forKey: .cc)
        rate = try container.decode(Double.self, forKey: .rate)
    }
}




