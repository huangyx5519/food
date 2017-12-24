//
//  testTableViewCell.swift
//  food
//
//  Created by hyx on 2017/12/25.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
