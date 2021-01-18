//
//  PaisesManager.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 18/01/21.
//

import Foundation

protocol PaisesManagerDelegate {
    func Actualizar(pais: PaisesModelo)
    func ErrorP(error: Error)
}

struct PaisesManager {
    var delegado: PaisesManagerDelegate?
    let url = "https://holidayapi.com/v1/countries?pretty&key=b4c0487e-b86f-4720-bbc9-11fffaa6f500"
    
    func ObtenerPaises() {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url, completionHandler: Handle(data:respuesta:error:))
            tarea.resume()
        }
    }
    
    
    func Handle(data: Data?, respuesta: URLResponse?, error: Error?) {
        if (error != nil) {
            delegado?.ErrorP(error: error!)
            return
        }
        if let datos = data {
            if let pais = self.Decodificar(pais: datos) {
                delegado?.Actualizar(pais: pais)
            }
        }
    }
    
    func Decodificar(pais: Data) -> PaisesModelo? {
        let decoder = JSONDecoder()
        var codigo = [String]()
        var nombre = [String]()
        var bandera = [String]()
        do {
            let decoded = try decoder.decode(PaisesData.self, from: pais)
            for p in decoded.countries {
                codigo.append(p.code)
                nombre.append(p.name)
                bandera.append(p.flag)
            }
            let pais = PaisesModelo(codigo: codigo, nombre: nombre, bandera: bandera)
            return pais
        }
        catch {
            delegado?.ErrorP(error: error)
            return nil
        }
    }
    
    
}
