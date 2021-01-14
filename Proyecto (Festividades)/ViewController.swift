//
//  ViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 13/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var BienvenidoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
    }
    
    func Estilos(){
        BienvenidoView.layer.cornerRadius = 10
        BienvenidoView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
    }


}

