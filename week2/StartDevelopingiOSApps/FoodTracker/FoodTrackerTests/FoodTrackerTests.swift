//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by byung-soo kwon on 2017. 6. 30..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
   
    //MARK: Meal Class Tests
    
    //Confirm that the Meal initializer returns a Meal object when passed while valid parameter
    func testMealinitializationSucceeds(){
        
        //Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //Highest positive rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
        
    }
    
    //Confirm that the Meal initializer returns nil when passed a negative rating or an empty name.
    func testMealinitializationFails(){
        
        //Negative Rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        //Empty Rating
        let emptyRatingMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyRatingMeal)
    }
    
}
