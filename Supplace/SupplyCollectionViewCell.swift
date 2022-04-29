//
//  SupplyCollectionViewCell.swift
//  Supplace
//
//  Created by Mirta Khairunnisa on 27/04/22.
//

import UIKit

class SupplyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var SupplyCollectionImg: UIImageView!
    @IBOutlet weak var SupplyCatColl: UILabel!
    func setup(with supply: Supply) {
        SupplyCollectionImg.image = supply.image
        SupplyCatColl.text = supply.name
    }
}
