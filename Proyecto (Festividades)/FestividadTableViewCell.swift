//
//  FestividadTableViewCell.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 15/01/21.
//

import UIKit

class FestividadTableViewCell: UITableViewCell {

    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var Fecha: UILabel!
    @IBOutlet weak var Tipo: UILabel!
    @IBOutlet weak var FestividadView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        FestividadView.layer.cornerRadius = 10
        FestividadView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
