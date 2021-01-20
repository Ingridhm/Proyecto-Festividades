//
//  FavoritosViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 17/01/21.
//

import Foundation
import UIKit
import Firebase

class FavoritosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Tabla: UITableView!
    @IBOutlet weak var FavoritasView: UIView!
    
    var favoritos: [Favorito] = []
    let id_usuario = (Auth.auth().currentUser?.uid)!
    let ref = Database.database().reference(withPath: "favoritos")
    var favref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        Tabla.dataSource = self
        Tabla.delegate = self
        Tabla.register(UINib(nibName: "FavoritoTableViewCell", bundle: nil), forCellReuseIdentifier: "celdafav")
        favref = self.ref.child("Favoritos-de-\(id_usuario)")
        favref!.observe(.value, with: { (snapshot) in
            var newItems: [Favorito] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                let favorito = Favorito(snapshot: snapshot) {
                    newItems.append(favorito)
                }
            }
            self.favoritos = newItems
            self.Tabla.reloadData()
        })
    }
    
    func Estilos() {
        Tabla.backgroundColor = UIColor.clear
        FavoritasView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        FavoritasView.layer.cornerRadius = 10
    }
    
    //NUMERO DE FILAS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritos.count
    }
    
    //INFO FILAS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = Tabla.dequeueReusableCell(withIdentifier: "celdafav") as! FavoritoTableViewCell
        let favorito = favoritos[indexPath.row]
        celda.Nombre.text = favorito.nombre.capitalized(with: nil)
        celda.Fecha.text = favorito.fecha
        return celda
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    //MARK:- ELIMINAR FAVORITO
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favorito = favoritos[indexPath.row]
            favorito.ref?.removeValue()
        }
    }
    
    
}
