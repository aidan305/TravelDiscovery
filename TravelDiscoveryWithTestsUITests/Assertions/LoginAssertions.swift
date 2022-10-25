//
//  LoginAssertions.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 15/02/2021.
//

import Foundation
import XCTest

class LoginAssertions {
    lazy var elements = LoginElements()
    
    func verifyUserIsLoggedIn(_ email: String) {
        let actualLoggedInMessage = elements.userLoggedInAlertMessage.label
        let expectedLoggedInMessage = "User is \(email) logged in"
        
        XCTAssertEqual(actualLoggedInMessage, expectedLoggedInMessage, "Expected message \(expectedLoggedInMessage) but got \(actualLoggedInMessage) ")
    }
    
    func verifyUserLoginFailed() {
        let expectedLoginFailedMessage = "Unable to Login due to incorrect login credentials"
        let actualLoginFailedMessage = elements.loginErrorMessage.label
        
        XCTAssertEqual(expectedLoginFailedMessage, actualLoginFailedMessage, "Expected message \(expectedLoginFailedMessage) but got \(actualLoginFailedMessage)")
    }
}
