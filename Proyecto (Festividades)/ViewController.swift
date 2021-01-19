//
//  ViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 13/01/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var BienvenidoView: UIView!
    @IBOutlet weak var CorreoField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "Inicio", sender: nil)
                self.CorreoField.text = nil
                self.PassField.text = nil
            }
        }
    }
    
    @IBAction func Login(_ sender: UIButton) {
        if (CorreoField.text == "" || PassField.text == ""){
            let alert = UIAlertController(title: "Error", message: "Por favor llene todos los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: CorreoField.text!, password: PassField.text!) { user, error in
                if let error = error, user == nil {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func Registrar(_ sender: UIButton) {
        if (CorreoField.text == "" || PassField.text == ""){
            let alert = UIAlertController(title: "Error", message: "Por favor llene todos los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: CorreoField.text!, password: PassField.text!) { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.CorreoField.text!, password: self.PassField.text!)
                }
                else {
                    let alert = UIAlertController(title: "Error",message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func Estilos(){
        BienvenidoView.layer.cornerRadius = 10
        BienvenidoView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        PassField.isSecureTextEntry = true
    }
    
}

