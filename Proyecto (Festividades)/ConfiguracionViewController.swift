//
//  ConfiguracionViewController.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 17/01/21.
//

import Foundation
import UIKit

class ConfiguracionViewController: UIViewController {
    
    @IBOutlet weak var ConfiguracionView: UIView!
    @IBOutlet weak var CorreoField: UITextField!
    @IBOutlet weak var AnteriorField: UITextField!
    @IBOutlet weak var NuevaField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfiguracionView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        ConfiguracionView.layer.cornerRadius = 10
    }
    
    @IBAction func GuardarConfiguracion(_ sender: Any) {
    }
}
