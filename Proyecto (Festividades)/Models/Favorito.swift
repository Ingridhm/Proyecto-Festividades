//
//  Favorito.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 19/01/21.
//

import Foundation
import Firebase

struct Favorito {
  
    let ref: DatabaseReference?
    let key: String
    let nombre: String
    let usuario: String
    let fecha: String
    var favorito: Bool
  
    init(nombre: String, fecha: String, usuario: String, favorito: Bool, key: String = "") {
        self.ref = nil
        self.key = key
        self.nombre = nombre
        self.usuario = usuario
        self.favorito = favorito
        self.fecha = fecha
    }
  
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject], let nombre = value["nombre"] as? String, let fecha = value["fecha"] as? String, let usuario = value["usuario"] as? String, let favorito = value["favorito"] as? Bool else {
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.nombre = nombre
        self.usuario = usuario
        self.favorito = favorito
        self.fecha = fecha
    }

    func toAnyObject() -> Any {
        return ["nombre": nombre, "fecha": fecha , "usuario": usuario, "favorito": favorito]
    }
}
