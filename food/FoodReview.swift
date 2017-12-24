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
    
    var title: String
    var photo: UIImage?
    var content: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.title = name
        self.photo = photo
        self.content = rating
        
    }
}
