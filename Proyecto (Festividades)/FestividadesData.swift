//
//  FestividadesData.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 17/01/21.
//

import Foundation

struct FestividadesData: Codable {
    let status: String
    let holidays: [Holidays]
}

struct Holidays: Codable {
    let name: String
    let date: String
    //let publi: Bool
}