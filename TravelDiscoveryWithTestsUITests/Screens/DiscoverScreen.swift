//
//  DiscoverScreen.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//

import Foundation
import XCTest

class DiscoverScreen {
    
    lazy var elements = DiscoverElements()
    
    func goToArtsScreen() {
        elements.artBtn.tap()
    }
    
    func goToSportsScreen() {
        elements.sportBtn.tap()
    }
    
    func goToLiveEventsScreen() {
        elements.liveEventsBtn.tap()
    }
    
    func goToFoodEventsScreen() {
        elements.foodBtn.tap()
    }
    
    func goToHistoryScreen() {
        elements.historyBtn.tap()
    }
    
    func goToLoginScreen() {
        elements.loginBtn.tap()
    }
    
    func goToRestaurantDetailsScreen(_ restaurantName: String) {
        let resturantElement = elements.getRestaurantElementByName(restaurantName)
        resturantElement.tap()
    }
}
