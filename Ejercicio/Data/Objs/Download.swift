//
//  Download.swift
//  Ejercicio
//
//  Created by Francisco Paramo Muñoz on 29/12/2018.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import Foundation

struct Download :Codable {
    var graph : [CentroCultural]?
    
    private enum CodingKeys: String, CodingKey {
        case graph = "@graph"
    }
}
