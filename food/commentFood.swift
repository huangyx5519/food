//
//  commentFood.swift
//  food
//
//  Created by hyx on 2017/12/25.
//  Copyright © 2017年 hyx. All rights reserved.
//

import Foundation
import UIKit

class commentFood : NSObject{
    var name: String?
    var desc: String?
    var comment: String?
    var photo : UIImage?
    
    
    init(name: String?, desc: String?,comment: String?,photo: UIImage?){
        self.name = name
        self.desc = desc
        self.comment = comment
        self.photo = photo
    }
}
