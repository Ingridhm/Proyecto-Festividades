//
//  FestividadesViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 15/01/21.
//

import Foundation
import UIKit

class FestividadesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var Tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabla.backgroundColor = UIColor.clear
        Tabla.dataSource = self
        Tabla.delegate = self
        Tabla.register(UINib(nibName: "FestividadTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
    }
    
    //NUMERO DE FILAS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //INFO FILAS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = Tabla.dequeueReusableCell(withIdentifier: "celda") as! FestividadTableViewCell
        celda.Fecha.text = "2021 / 02 / 21"
        celda.Tipo.text = "Privado"
        return celda
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //SEGUE
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //DELETE
    }*/
}
