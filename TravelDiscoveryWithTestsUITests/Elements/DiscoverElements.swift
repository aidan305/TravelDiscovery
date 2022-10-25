//
//  DiscoverElements.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//

import Foundation
import XCTest

class DiscoverElements: BaseElements {
    
    lazy var loginBtn = app.buttons["DiscoverLoginBtn"]
    
    //MARK: Categories
    lazy var searchBox = app.staticTexts["SearchBox"]
    lazy var artBtn = app.buttons["ArtCell"]
    lazy var sportBtn = app.buttons["SportsCell"]
    lazy var liveEventsBtn = app.buttons["Live EventsCell"]
    lazy var foodBtn = app.buttons["FoodCell"]
    lazy var historyBtn = app.buttons["HistoryCell"]
    
    //MARK: Restaurant    
    func getRestaurantElementByName(_ restaurantName: String) -> XCUIElement {
        let predicateCondition = NSPredicate(format: "label CONTAINS[c] '\(restaurantName)'")
        return app.buttons.containing(predicateCondition).element(boundBy: 0)
    }
    
}
