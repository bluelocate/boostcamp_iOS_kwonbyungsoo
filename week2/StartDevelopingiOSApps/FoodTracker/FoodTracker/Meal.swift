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
    
    //실패할 수 있기 때문에 (init?)
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating

        //Initialization should fail if there is no name or if the rating is negative
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
    }
    
    
    
}

