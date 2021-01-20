//
//  FestividadesViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 15/01/21.
//

import Foundation
import UIKit
import Firebase
import MapKit

class FestividadesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,CLLocationManagerDelegate, FestividadesManagerDelegate, PaisesManagerDelegate {
    
    @IBOutlet weak var Tabla: UITableView!
    @IBOutlet weak var BuscarView: UIView!
    @IBOutlet weak var PaisField: UITextField!
    @IBOutlet weak var PaisesView: UIView!
    @IBOutlet weak var AvanzadaView: UIView!
    
    var festividadesmanager = FestividadesManager()
    var paisesmanager = PaisesManager()
    var locationmanager = CLLocationManager()
    var nombres = [String]()
    var fechas = [String]()
    var dias = [String]()
    var imagenes = [UIImage]()
    var paises = [String]()
    var paisfield = UITextField()
    var mesfield = UITextField()
    var diafield = UITextField()
    var usuario: User!
    var favoritos: [Favorito] = []
    let correo = (Auth.auth().currentUser?.email)!
    let id_usuario = (Auth.auth().currentUser?.uid)!
    let ref = Database.database().reference(withPath: "favoritos")
    var favref: DatabaseReference?
    var ubicacion = ""
    let defaults = UserDefaults.standard
    var busqueda = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        festividadesmanager.delegado = self
        paisesmanager.delegado = self
        Tabla.dataSource = self
        Tabla.delegate = self
        diafield.delegate = self
        Tabla.allowsSelection = true
        Tabla.isUserInteractionEnabled = true
        Tabla.register(UINib(nibName: "FestividadTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        favref = self.ref.child("Favoritos-de-\(id_usuario)")
        favref!.observe(.value, with: { snapshot in
            var newItems: [Favorito] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let fav = Favorito(snapshot: snapshot) {
                    newItems.append(fav)
                }
            }
            self.favoritos = newItems
            self.Tabla.reloadData()
        })
        if let guardado = defaults.string(forKey: "Busqueda") {
            busqueda = guardado
            PaisField.text = busqueda.uppercased()
            festividadesmanager.ObtenerFestividades(pais: PaisField.text!)
        }
        print("Busqueda: \(busqueda)")
        //locationmanager.requestLocation()
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
    
    //MARK:- GUARDAR ULTIMA BÚSQUEDA
    func Guardar() {
        self.defaults.set(self.PaisField.text, forKey: "Busqueda")
    }
    
    //NUMERO DE FILAS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nombres.count
    }
    
    //INFO FILAS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = Tabla.dequeueReusableCell(withIdentifier: "celda") as! FestividadTableViewCell
        celda.Nombre.text = nombres[indexPath.row].capitalized(with: nil)
        celda.Fecha.text = fechas[indexPath.row]
        celda.Tipo.text = dias[indexPath.row]
        celda.FavoritoView.image = imagenes[indexPath.row]
        return celda
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    //MARK:- FAVORITO
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectfest = nombres[indexPath.row]
        let selectfecha = fechas[indexPath.row]
        let fav = Favorito(nombre: selectfest, fecha: selectfecha, usuario: correo, favorito: true)
        imagenes[indexPath.row] = UIImage(systemName: "suit.heart.fill")!.withTintColor(UIColor.init(red: 155, green: 45, blue: 47, alpha: 1))
        let favoritofestref = self.favref!.child(selectfest)
        favoritofestref.setValue(fav.toAnyObject())
        Tabla.reloadData()
    }
    
    //MARK:- BÚSQUEDA AVANZADA (BUTTON)
    @IBAction func BusquedaAvanzada(_ sender: UIButton) {
        let alert = UIAlertController(title: "Busqueda Avanzada", message: nil, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            self.festividadesmanager.ObtenerFestividadesAvanzada(pais: self.paisfield.text!, dia: self.diafield.text!, mes: self.mesfield.text!)
            self.PaisField.text = self.paisfield.text
            //self.Guardar()
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        aceptar.isEnabled = false
        alert.addAction(aceptar)
        alert.addAction(cancelar)
        alert.addTextField { (alertpais) in
            alertpais.placeholder = "Código del País"
            self.paisfield = alertpais
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alertpais, queue: OperationQueue.main, using: { (_) in
                let textCount = alertpais.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                let textIsNotEmpty = textCount > 0
                aceptar.isEnabled = textIsNotEmpty
            })
        }
        alert.addTextField { (alertmes) in
            alertmes.placeholder = "Mes"
            self.mesfield = alertmes
        }
        alert.addTextField { (alertdia) in
            alertdia.placeholder = "Día"
            self.diafield = alertdia
        }
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
        locationmanager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Se obtuvo la ubicación")
        if let lugar = locations.last {
            locationmanager.stopUpdatingLocation()
            let latitud = lugar.coordinate.latitude
            let longitud = lugar.coordinate.longitude
            print("Latitud: \(latitud), Longitud: \(longitud)")
            let location = CLLocation(latitude: latitud, longitude: longitud)
            location.fetchCityAndCountry { (city, country, error) in
                guard let country = country, error == nil else {
                    return
                }
                print(country)
                self.ubicacion = country
                self.paisesmanager.ObtenerPais()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //MARK:- BUSCAR FESTIVIDADES (BUTTON)
    @IBAction func Buscar(_ sender: UIButton) {
        if (PaisField.text == "") {
            let alert = UIAlertController(title: "Campo en blanco", message: "Por favor llene todos los campos", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            present(alert, animated: true, completion: nil)
        }
        else if (PaisField.text!.count > 2) {
            let alert = UIAlertController(title: "Formato Erroneo", message: "Por favor ingrese un código de país válido", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            present(alert, animated: true, completion: nil)
        }
        else {
            festividadesmanager.ObtenerFestividades(pais: PaisField.text!)
        }
    }
    
    //MARK:- API FESTIVIDADES
    func Actualizar(festividad: FestividadesModelo) {
        self.nombres.removeAll()
        self.fechas.removeAll()
        DispatchQueue.main.async { [self] in
            for t in 0..<festividad.nombre.count {
                self.nombres.append(festividad.nombre[t])
                self.fechas.append(festividad.fecha[t])
                self.dias.append(festividad.dia[t])
                self.imagenes.append(UIImage(systemName: "suit.heart")!)
                imagenes[t] = UIImage(systemName: "suit.heart")!
                for favorito in self.favoritos {
                    if (favorito.nombre == festividad.nombre[t]) {
                        imagenes[t] = UIImage(systemName: "suit.heart.fill")!
                        //print("FAV: \(favorito.nombre) - \(festividad.nombre[t])")
                    }
                }
                //print("\(nombres[t]) - \(imagenes[t])")
            }
            self.Tabla.reloadData()
            Guardar()
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
                    self.festividadesmanager.ObtenerFestividades(pais: self.PaisField.text!)
                }
            }
            for p in self.paises {
                alert.addAction(UIAlertAction(title: p, style: .default, handler: closure))
            }
            alert.addAction(UIAlertAction(title: "CERRAR", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func ActualizarU(pais: PaisesModelo) {
        DispatchQueue.main.async {
            for p in 0..<pais.nombre.count {
                self.paises.append("\(pais.codigo[p]) - \(pais.nombre[p])")
                if (pais.nombre[p].capitalized == self.ubicacion.capitalized) {
                    print(pais.codigo[p])
                    self.PaisField.text = pais.codigo[p]
                }
            }
            self.festividadesmanager.ObtenerFestividades(pais: self.PaisField.text!)
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
    
    func ErrorU(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Ocurrió un error al encontrar su ubicación", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK:- UBICACIÓN Y NOMBRE PAIS
extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
