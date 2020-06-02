//
//  foodCell.swift
//  ExamApp
//
//  Created by OparinOleg on 31.05.2020.
//  Copyright © 2020 OparinOleg. All rights reserved.
//

import UIKit

class foodCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
