//
//  CuentaViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 16/01/21.
//

import Foundation
import UIKit
import Firebase

class CuentaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var OpcionesGrid: UICollectionView!
    
    let opciones = ["Configuración", "Favoritos", "Cerrar Sesión"]
    let images = [UIImage(named: "settings.svg"), UIImage(named: "favourites.svg"), UIImage(named: "logout.svg")]
    var seleccionado : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OpcionesGrid.delegate = self
        OpcionesGrid.dataSource = self
        OpcionesGrid.backgroundColor = UIColor.clear
        OpcionesGrid.register(UINib(nibName: "OpcionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "opcion")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let grid = OpcionesGrid.dequeueReusableCell(withReuseIdentifier: "opcion", for: indexPath) as! OpcionCollectionViewCell
        grid.GridLabel.text = opciones[indexPath.row]
        grid.GridButton.setImage(images[indexPath.row], for: .normal)
        return grid
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (opciones[indexPath.row] == "Configuración") {
            performSegue(withIdentifier: "configuracion", sender: nil)
        }
        else if (opciones[indexPath.row] == "Favoritos") {
            performSegue(withIdentifier: "favoritos", sender: nil)
        }
        else {
            //let user = Auth.auth().currentUser!
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            }
            catch (let error) {
                print("Error al cerrar sesión: \(error)")
            }
            /*let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
            onlineRef.removeValue { (error, _) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                do {
                    try Auth.auth().signOut()
                    self.dismiss(animated: true, completion: nil)
                }
                catch (let error) {
                    print("Auth sign out failed: \(error)")
                }*/
            performSegue(withIdentifier: "cerrar-sesion", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if segue.identifier == "EnviarNombre" {
            let destino = segue.destination as! InicioViewController
            destino.alumno = seleccionado
        }*/
    }
    
}
