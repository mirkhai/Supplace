//
//  LogsTableViewCell.swift
//  Supplace
//
//  Created by Mirta Khairunnisa on 27/04/22.
//

import UIKit

class LogsTableViewCell: UITableViewCell {
    
    @IBOutlet var cellBgColor: UIView!
    @IBOutlet weak var supplyNameLabel: UILabel!
    @IBOutlet weak var supplyCatLabel: UILabel!
    @IBOutlet weak var storageCatLabel: UILabel!
    @IBOutlet weak var itsALabel: UILabel!
    @IBOutlet weak var storedInLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var supplyImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        // Configure the view for the selected state

}
