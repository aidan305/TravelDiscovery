//
//  RestaurantAssertions.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 16/02/2021.
//

import Foundation
import XCTest

class RestaurantAssertions {
    lazy var elements = RestaurantElements()
    
    func verifyCorrectRestaurantIsDisplayed(_ expectedRestaurantName: String) {
        let actualRestaurantDisplayed =  elements.restaurantName.label
        
        XCTAssertEqual(expectedRestaurantName, actualRestaurantDisplayed, "Expected \(expectedRestaurantName) but got \(actualRestaurantDisplayed)")
    }
}
