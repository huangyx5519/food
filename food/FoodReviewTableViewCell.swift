//
//  FoodReviewTableViewCell.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit

class FoodReviewTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
