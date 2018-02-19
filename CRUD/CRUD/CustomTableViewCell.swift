//
//  CustomTableViewCell.swift
//  Saving Data BayBeh
//
//  Created by Пользователь on 18.02.2018.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var addresLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
