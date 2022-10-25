//
//  GivenSteps.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//

import Foundation
import Cucumberish

class GivenSteps {
    
    private var discoverScreen = DiscoverScreen()
    
    func setupSteps(){
        Given("I am on home page") { args, _ in
            self.discoverScreen.elements.searchBox.waitForExistence(timeout: 5)
        }
        
        Given("^I am on login page") { args, _ in
            self.discoverScreen.goToLoginScreen()
        }
    }
}
