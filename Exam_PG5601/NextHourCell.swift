//
//  NextHourCell.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 26/10/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import UIKit

class NextHourCell: UITableViewCell {

    
    @IBOutlet weak var whatHour: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var rainAmountLabel: UILabel!
    @IBOutlet weak var whatTypeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
