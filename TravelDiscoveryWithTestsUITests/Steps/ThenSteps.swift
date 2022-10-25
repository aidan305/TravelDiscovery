//
//  ThenSteps.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//
import Foundation
import Cucumberish

class ThenSteps {
    
    private var categoryScreen = CategoryDetailsScreen()
    private var loginScreen = LoginScreen()
    private var restaurantScreen = RestaurantScreen()
    
    func setupSteps(){
        Then("^I should see the (.*) category screen") { args, _ in
            let category = (args?[0])!
            self.categoryScreen.assertions.verifyCategoryScreenDisplayed(category)
        }
        
        Then("^I should see my (.*) logged in") { [self] args, _ in
            guard let email = args?[0] else {
                XCTFail("no username exists")
                return
            }
            loginScreen.assertions.verifyUserIsLoggedIn(email)
        }
        
        Then("^I should see the incorrect login credentials error message") { args, _ in
            self.loginScreen.assertions.verifyUserLoginFailed()
        }
        
        Then("^I should see the (.*) restaurant screen") { [self] args, _ in
            guard let restaurant = args?[0] else {
                XCTFail("no restaurant exists")
                return
            }
            restaurantScreen.assertions.verifyCorrectRestaurantIsDisplayed(restaurant)
        }
        
        
        
        
       
    }
}
