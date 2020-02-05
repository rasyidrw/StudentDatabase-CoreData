//
//  SiswaTableViewCell.swift
//  CoreDataSiswa
//
//  Created by Rasyid Respati Wiriaatmaja on 04/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit

class SiswaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNama: UILabel!
    @IBOutlet weak var lblAsal: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
