//
//  Meal.swift
//  FoodTracker
//
//  Created by byung-soo kwon on 2017. 7. 7..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating

        
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    
    
}

