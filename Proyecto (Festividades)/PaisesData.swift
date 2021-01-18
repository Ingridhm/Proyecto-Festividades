//
//  PaisesData.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 18/01/21.
//

import Foundation

struct PaisesData: Codable {
    let countries: [Countries]
}

struct Countries: Codable {
    let code: String
    let name: String
    let flag: String
}
