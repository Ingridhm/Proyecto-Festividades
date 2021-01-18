//
//  FestividadesViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 15/01/21.
//

import Foundation
import UIKit

class FestividadesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, FestividadesManagerDelegate, PaisesManagerDelegate {
    
    @IBOutlet weak var Tabla: UITableView!
    @IBOutlet weak var BuscarView: UIView!
    @IBOutlet weak var PaisField: UITextField!
    @IBOutlet weak var AñoField: UITextField!
    @IBOutlet weak var PaisesView: UIView!
    @IBOutlet weak var AvanzadaView: UIView!
    
    var festividadesmanager = FestividadesManager()
    var paisesmanager = PaisesManager()
    var nombres = [""]
    var fechas = [""]
    var paises = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        festividadesmanager.delegado = self
        paisesmanager.delegado = self
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
        BuscarView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        BuscarView.layer.cornerRadius = 10
        PaisesView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        PaisesView.layer.cornerRadius = 10
        AvanzadaView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        AvanzadaView.layer.cornerRadius = 10
    }
    
    //MARK:- BÚSQUEDA AVANZADA (BUTTON)
    @IBAction func BusquedaAvanzada(_ sender: UIButton) {
        let alert = UIAlertController(title: "Busqueda Avanzada", message: nil, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        let cancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alert.addAction(aceptar)
        alert.addAction(cancelar)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- LISTADO DE PAISES (BUTTON)
    @IBAction func ListaPaises(_ sender: UIButton) {
        if (!paises.isEmpty) {
            paises.removeAll()
        }
        paisesmanager.ObtenerPaises()
    }
    
    
    //MARK:- UBICACIÓN (BUTTON)
    @IBAction func Ubicacion(_ sender: UIButton) {
        
    }
    
    //MARK:- BUSCAR FESTIVIDADES (BUTTON)
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
    
    //MARK:- API FESTIVIDADES
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
    
    //MARK:- API PAISES
    func Actualizar(pais: PaisesModelo) {
        DispatchQueue.main.async {
            for p in 0..<pais.nombre.count {
                self.paises.append("\(pais.codigo[p]) - \(pais.nombre[p])")
                print("\(pais.codigo[p]) - \(pais.nombre[p])")
            }
            let alert = UIAlertController(title: "Lista de Países", message: nil, preferredStyle: .alert)
            let closure = { (action: UIAlertAction!) -> Void in
                let index = alert.actions.firstIndex(of: action)
                if index != nil {
                    print("Index: \(index!)")
                    self.PaisField.text = String(self.paises[index!].prefix(2))
                }
            }
            for p in self.paises {
                alert.addAction(UIAlertAction(title: p, style: .default, handler: closure))
            }
            alert.addAction(UIAlertAction(title: "CERRAR", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func ErrorP(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Ocurrió un error al consultar la lista", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
