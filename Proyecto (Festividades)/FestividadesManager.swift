//
//  FestividadesManager.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 17/01/21.
//

import Foundation

protocol FestividadesManagerDelegate {
    
}

struct FestividadesManager {
    var delegado: FestividadesManagerDelegate?
    let url = "https://holidayapi.com/v1/holidays?pretty&key=b4c0487e-b86f-4720-bbc9-11fffaa6f500"
    
    func ObtenerFestividades(pais: String, año: String) {
        let urls = "\(url)&country=\(pais)&year=\(año)"
        Solicitar(urls: urls)
    }
    
    func Solicitar(urls: String) {
        if let url = URL(string: urls) {
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url, completionHandler: Handle(data:respuesta:error:))
            tarea.resume()
        }
    }
    
    func Handle(data: Data?, respuesta: URLResponse?, error: Error?) {
        /*if (error != nil) {
            //delegado?.Error(error: error!)
            return
        }
        if let datos = data {
            if let fest = self.Decodificar(fest: datos) {
                //delegado?.Actualizar(fest: fest)
            }
        }*/
    }
    
    /*func Decodificar(fest: Data) -> FestividadesModelo? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(FestividadesData.self, from: fest)
            let status = decoded.status
            let nombre = decoded.holidays[0].name
            let fecha = decoded.holidays[0].date
            //let tipo = decoded.holidays[0].date
            //let festividad = FestividadesModelo(status: status, nombre: nombre, fecha: fecha, tipo: tipo)
            let festividad = FestividadesModelo(status: status, nombre: nombre, fecha: fecha)
            return festividad
        }
        catch {
            //print(error)
            //delegado?.Error(error: error)
            return nil
        }
    }*/
    
}
