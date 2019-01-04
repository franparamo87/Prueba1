//
//  Organization.swift
//  Ejercicio
//
//  Created by Francisco Paramo Muñoz on 29/12/2018.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import Foundation

struct Organization :Codable {
    var desc : String?
    var name : String?
    var services : String?
    
    private enum CodingKeys: String, CodingKey {
        case services
        case desc = "organization-desc"
        case name = "organization-name"
    }
}
