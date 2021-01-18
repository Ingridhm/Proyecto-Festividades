//
//  FestividadesViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 15/01/21.
//

import Foundation
import UIKit

class FestividadesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, FestividadesManagerDelegate {
    
    @IBOutlet weak var Tabla: UITableView!
    @IBOutlet weak var BuscarView: UIView!
    @IBOutlet weak var PaisField: UITextField!
    @IBOutlet weak var AñoField: UITextField!
    
    var festividadesmanager = FestividadesManager()
    var nombres = [""]
    var fechas = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        festividadesmanager.delegado = self
        Tabla.dataSource = self
        Tabla.delegate = self
        Tabla.register(UINib(nibName: "FestividadTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
    }
    
    //NUMERO DE FILAS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nombres.count
    }
    
    //INFO FILAS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = Tabla.dequeueReusableCell(withIdentifier: "celda") as! FestividadTableViewCell
        celda.Nombre.text = nombres[indexPath.row]
        celda.Fecha.text = fechas[indexPath.row]
        return celda
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func Estilos() {
        Tabla.backgroundColor = UIColor.clear
        BuscarView.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        BuscarView.layer.cornerRadius = 10
    }
    
    
    //MARK:- FIELD
    @IBAction func Buscar(_ sender: UIButton) {
        if (PaisField.text == "" || AñoField.text == "") {
            let alert = UIAlertController(title: "Campo en blanco", message: "Por favor llene todos los campos", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            present(alert, animated: true, completion: nil)
        }
        else {
            festividadesmanager.ObtenerFestividades(pais: PaisField.text!, año: AñoField.text!)
        }
    }
    
    //MARK:- API
    func Actualizar(festividad: FestividadesModelo) {
        self.nombres.removeAll()
        self.fechas.removeAll()
        DispatchQueue.main.async {
            for t in 0..<festividad.nombre.count {
                self.nombres.append(festividad.nombre[t])
                self.fechas.append(festividad.fecha[t])
            }
            self.Tabla.reloadData()
        }
    }
    
    func Error(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Por favor verifique que los datos introducidos sean correctos", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
