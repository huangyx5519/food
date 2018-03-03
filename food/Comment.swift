//
//  Comment.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import Foundation

import UIKit

class Comment {
    
    //MARK: Properties
    
    var content: String
    var userName: String
    
    //MARK: Initialization
    
    init?(content: String, userName: String) {
        
        // The name must not be empty
        guard !content.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.content = content
        self.userName = userName
    }
}
