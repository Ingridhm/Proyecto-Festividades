//
//  OpcionCollectionViewCell.swift
//  Proyecto (Festividades)
//
//  Created by Ingrid on 17/01/21.
//

import UIKit

class OpcionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var GridView: UIView!
    @IBOutlet weak var GridButton: UIButton!
    @IBOutlet weak var GridLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        GridView.layer.cornerRadius = 10
        GridView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
    }
    
}
