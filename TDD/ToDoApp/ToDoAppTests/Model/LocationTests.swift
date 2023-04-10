//
//  LocationTests.swift
//  ToDoAppTests
//
//  Created by Mustafa Bekirov on 08.04.2023.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class LocationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitSetsName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
    }
    
    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(
            latitude: 1,
            longitude: 2
        )
        let location = Location(name: "Foo",
                                coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func testCanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Foo", coordinate: CLLocationCoordinate2D(latitude: 10.0, longitude: 10.0))
        let dict: [String : Any] = ["name" : "Foo",
                                    "latitude" : 10.0,
                                    "longitude" : 10.0]
        
        let createdLocation = Location(dict: dict)
        
        XCTAssertEqual(location, createdLocation)
    }
}
