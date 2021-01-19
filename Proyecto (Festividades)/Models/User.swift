//
//  User.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 19/01/21.
//

import Foundation
import Firebase

struct User {
  
    let user_id: String
    let correo: String

    init(authData: Firebase.User) {
        user_id = authData.uid
        correo = authData.email!
    }

    init(user_id: String, correo: String) {
        self.user_id = user_id
        self.correo = correo
    }
}

