//
//  StorageCollectionViewCell.swift
//  Supplace
//
//  Created by Mirta Khairunnisa on 27/04/22.
//

import UIKit

class StorageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var StorageCollectionImg: UIImageView!
    @IBOutlet var StorageCatColl: UILabel!
    func setup(with storage: Storage) {
        StorageCollectionImg.image = storage.imageSt
        StorageCatColl.text = storage.nameSt
    }
}
