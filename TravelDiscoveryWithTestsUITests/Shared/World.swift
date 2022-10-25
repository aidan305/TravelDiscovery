//
//  World.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 16/02/2021.
//

import Foundation
import XCTest

class World {
    static var shared = World()
    var selectedRestaurant: String?
}

// to set any var or access in code use : world.shared.selectedRestaurant
