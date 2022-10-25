//
//  WhenSteps.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//

import Foundation
import Cucumberish

class WhenSteps {
    
    private var discoverScreen = DiscoverScreen()
    private var loginScreen = LoginScreen()
    
    func setupSteps(){
        When("^I select (.*) category") { args, _ in
            let categoryToSelect = args?[0]
            switch categoryToSelect {
            case "Art":
                self.discoverScreen.goToArtsScreen()
            case "Sports":
                self.discoverScreen.goToSportsScreen()
            case "Live Events":
                self.discoverScreen.goToLiveEventsScreen()
            case "Food":
                self.discoverScreen.goToFoodEventsScreen()
            case "History":
                self.discoverScreen.goToHistoryScreen()
            default:
                XCTFail("Unable to select category \(String(describing: categoryToSelect))")
            }
        }
        
        When("^I enter my (.*) and (.*) to login") { [self] args, _ in
            guard let username = args?[0] else {
                XCTFail("no username exists")
                return
            }
            guard let password = args?[1] else {
                XCTFail("no username exists")
                return
            }
            loginScreen.loginWithCredentials(username, password)
        }
        
        When("^I select (.*) restaurant") { args, _ in
            guard let restaurant = args?[0] else {
                XCTFail("no restaurant exists")
                return
            }
            self.discoverScreen.goToRestaurantDetailsScreen(restaurant)
        }
        
    }
}
