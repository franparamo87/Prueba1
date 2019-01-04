//
//  Address.swift
//  Ejercicio
//
//  Created by Francisco Paramo Muñoz on 29/12/2018.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import Foundation

struct Address :Codable {
    var locality : String?
    var postal_code : String?
    var street_address : String?
    
    private enum CodingKeys: String, CodingKey {
        case locality
        case postal_code = "postal-code"
        case street_address = "street-address"
    }
}
