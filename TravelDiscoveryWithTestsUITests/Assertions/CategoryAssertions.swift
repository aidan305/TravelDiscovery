//
//  CategoryAssertions.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//

import Foundation
import XCTest

class CategoryAssertions {
    
    lazy var elements = CategoryDetailsElements()
    
    func verifyCategoryScreenDisplayed(_ expectedScreen: String){
        let actualScreenTitle = elements.navBarTitle.label
        
        XCTAssertEqual(expectedScreen, actualScreenTitle, "Expected to see \(actualScreenTitle), but got \(expectedScreen)")
    }
}
