//
//  FestividadesViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 15/01/21.
//

import Foundation
import UIKit

class FestividadesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var Tabla: UITableView!
    @IBOutlet weak var BuscarView: UIView!
    @IBOutlet weak var PaisField: UITextField!
    @IBOutlet weak var AñoField: UITextField!
    
    var festividadesmanager = FestividadesManager()
    var opciones = ["2021 / 01 / 01", "2021 / 01 / 02", "2021 / 01 / 03", "2021 / 01 / 04", "2021 / 01 / 05", "2021 / 01 / 06", "2021 / 01 / 07", "2021 / 01 / 08", "2021 / 01 / 09", "2021 / 01 / 10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        //festividadesmanager.delegado = self
        PaisField.delegate = self
        AñoField.delegate = self
        Tabla.dataSource = self
        Tabla.delegate = self
        Tabla.register(UINib(nibName: "FestividadTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
    }
    
    //NUMERO DE FILAS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opciones.count
    }
    
    /*func Actualizar(fest: FestividadesModelo) {
        print("ah")
    }*/
    
    //INFO FILAS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = Tabla.dequeueReusableCell(withIdentifier: "celda") as! FestividadTableViewCell
        celda.Fecha.text = opciones[indexPath.row]
        celda.Tipo.text = "Privado"
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
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //SEGUE
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //DELETE
    }*/
    
    
    //MARK:- FIELD
    @IBAction func Buscar(_ sender: UIButton) {
        if (PaisField.text == "" || AñoField.text == "") {
            let alert = UIAlertController(title: "Campo en blanco", message: "Por favor llene todos los campos", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            present(alert, animated: true, completion: nil)
        }
        else {
            //festividadesmanager.ObtenerFestividades(pais: PaisField.text!, año: AñoField.text!)
            opciones = ["2021 / 01 / 11", "2021 / 01 / 12", "2021 / 01 / 13", "2021 / 01 / 14", "2021 / 01 / 15", "2021 / 01 / 16", "2021 / 01 / 17", "2021 / 01 / 18", "2021 / 01 / 19", "2021 / 01 / 20"]
            Tabla.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(BuscarField.text!)
        //CiudadLabel.text = BuscarField.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        /*if (BuscarField.text != "") {
            return true
        }
        else {
            BuscarField.placeholder = "Ingresa una ciudad"
            return false
        }*/
        return true
    }
    
}
//MARK:- API

/*extension ViewController: ClimaManagerDelegate {
    func Actualizar(clima: ClimaModelo) {
        print("CLIMA")
        print("Descripción: \(clima.descripcion)")
        print("Temperatura: \(clima.Temperatura)")
        DispatchQueue.main.async {
            self.ClimaLabel.text = clima.descripcion.capitalized
            self.TemperaturaLabel.text = "\(clima.Temperatura) °C"
            self.ClimaImage.image = UIImage(named: clima.condicion)
            self.BackgroundImage.image = UIImage(named: clima.background)
            self.CiudadLabel.text = clima.ciudad
            self.SensacionLabel.text = "\(clima.Sensacion) °C"
            self.MaximaLabel.text = "\(clima.Maxima) °C"
            self.MinimaLabel.text = "\(clima.Minima) °C"
            self.HumedadLabel.text = "\(String(clima.humedad)) %"
            self.VelocidadLabel.text = "\(clima.velocidad) m/s"
            self.DireccionLabel.text = clima.Direccion
        }
    }
    
    func Error(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            self.Limpiar()
            let alert = UIAlertController(title: "Ciudad no encontrada", message: "Por favor verifique que el nombre de la ciudad ingresada sea correcto", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func Limpiar() {
        CiudadLabel.text = "Desconocido"
        ClimaLabel.text = "-"
        TemperaturaLabel.text = "?"
        ClimaImage.image = UIImage(named: "icon-cloudy-day.svg")
        BackgroundImage.image = UIImage(named: "dawn.jpeg")
        SensacionLabel.text = "-"
        MaximaLabel.text = "_"
        MinimaLabel.text = "-"
        HumedadLabel.text = "-"
        VelocidadLabel.text = "-"
        DireccionLabel.text = "-"
        Dia1Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia1Label.text = "-"
        Dia2Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia2Label.text = "-"
        Dia3Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia3Label.text = "-"
        Dia4Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia4Label.text = "-"
        Dia5Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia5Label.text = "-"
        Fecha1Label.text = "Día 1"
        Fecha2Label.text = "Día 2"
        Fecha3Label.text = "Día 3"
        Fecha4Label.text = "Día 4"
        Fecha5Label.text = "Día 5"
    }
}*/
