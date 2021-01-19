//
//  FestividadesManager.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 17/01/21.
//

import Foundation

protocol FestividadesManagerDelegate {
    func Actualizar(festividad: FestividadesModelo)
    func Error(error: Error)
}

struct FestividadesManager {
    var delegado: FestividadesManagerDelegate?
    let url = "https://holidayapi.com/v1/holidays?pretty&key=b4c0487e-b86f-4720-bbc9-11fffaa6f500&language=es"
    
    func ObtenerFestividades(pais: String) {
        let urls = "\(url)&country=\(pais)&year=2020"
        Solicitar(urls: urls)
    }
    
    func ObtenerFestividadesAvanzada(pais: String, dia: String, mes: String) {
        var urls = "\(url)&country=\(pais)&year=2020"
        if (mes != "" ) {
            urls = "\(urls)&month=\(mes)"
        }
        if (dia != "" ) {
            urls = "\(urls)&day=\(dia)"
        }
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
        if (error != nil) {
            delegado?.Error(error: error!)
            return
        }
        if let datos = data {
            if let festividad = self.Decodificar(festividad: datos) {
                delegado?.Actualizar(festividad: festividad)
            }
        }
    }
    
    func Decodificar(festividad: Data) -> FestividadesModelo? {
        let decoder = JSONDecoder()
        var nombre = [String]()
        var fecha = [String]()
        var dia = [String]()
        do {
            let decoded = try decoder.decode(FestividadesData.self, from: festividad)
            let status = decoded.status
            for f in decoded.holidays {
                nombre.append(f.name)
                fecha.append(f.date)
                dia.append(f.weekday.date.name)
            }
            let festividad = FestividadesModelo(status: status, nombre: nombre, fecha: fecha, dia: dia)
            return festividad
        }
        catch {
            delegado?.Error(error:error)
            return nil
        }
    }
    
}
