//
//  CentroCultural.swift
//  Ejercicio
//
//  Created by Francisco Paramo Muñoz on 29/12/2018.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import Foundation

@objc class CentroCultural :NSObject, Codable {
    var id : String?
    var title : String?
    var address : Address?
    var location : Location?
    var organization : Organization?
    
    @objc func getTitle() -> NSString {
        guard let tit = title else {
            return ""
        }
        return tit as NSString
    }
}


