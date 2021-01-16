//
//  FestividadTableViewCell.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 15/01/21.
//

import UIKit

class FestividadTableViewCell: UITableViewCell {

    @IBOutlet weak var Fecha: UILabel!
    @IBOutlet weak var Tipo: UILabel!
    @IBOutlet weak var FestividadView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        FestividadView.layer.cornerRadius = 10
        FestividadView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        //CeldaView.layer.cornerRadius = 10
        //CeldaView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}