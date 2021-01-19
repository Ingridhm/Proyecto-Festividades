//
//  FavoritoTableViewCell.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 19/01/21.
//

import UIKit

class FavoritoTableViewCell: UITableViewCell {

    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var Fecha: UILabel!
    @IBOutlet weak var Dia: UILabel!
    @IBOutlet weak var Pais: UILabel!
    @IBOutlet weak var FavoritoView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        FavoritoView.layer.cornerRadius = 10
        FavoritoView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
