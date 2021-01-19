//
//  ConfiguracionViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 17/01/21.
//

import Foundation
import UIKit
import Firebase

class ConfiguracionViewController: UIViewController {
    
    @IBOutlet weak var ConfiguracionView: UIView!
    @IBOutlet weak var CorreoField: UITextField!
    @IBOutlet weak var NuevaField: UITextField!
    
    let ref = Database.database().reference(withPath: "favoritos")
    var favref: DatabaseReference?
    let id_usuario = (Auth.auth().currentUser?.uid)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfiguracionView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        ConfiguracionView.layer.cornerRadius = 10
        favref = self.ref.child("Favoritos-de-\(id_usuario)")
    }
    
    @IBAction func GuardarConfiguracion(_ sender: Any) {
        if (CorreoField.text == "" && NuevaField.text == "") {
            let alert = UIAlertController(title: "Error", message: "Por favor llene al menos un campo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if (CorreoField.text != "") {
                Auth.auth().currentUser?.updateEmail(to: CorreoField.text!) { (error) in
                    if (error == nil) {
                        let alert = UIAlertController(title: "", message: "El correo fue actualizado con éxito", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        self.CorreoField.text = ""
                    }
                    else {
                        let alert = UIAlertController(title: "Error",message: "Ese correo ya esta asociado con otra cuenta", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            if (NuevaField.text != "") {
                Auth.auth().currentUser?.updatePassword(to: NuevaField.text!) { (error) in
                    if (error == nil){
                        let alert = UIAlertController(title: "", message: "La contraseña fue actualizado con éxito", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        self.NuevaField.text = ""
                    }
                    else {
                        let alert = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
