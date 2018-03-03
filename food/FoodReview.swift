//
//  FoodReview.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import Foundation

import UIKit

class FoodReview {
    
    //MARK: Properties
    var id: String
    var title: String
    var photo: UIImage?
    var rating: Int
    var desc: String
    var userName: String
    
    //MARK: Initialization
    
    init?(id: String, title: String, photo: UIImage?, rating: Int,desc: String, userName: String) {
        
        // The name must not be empty
        guard !title.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.id = id
        self.title = title
        self.photo = photo
        self.rating = rating
        self.desc = desc
        self.userName = userName
        
    }
}
