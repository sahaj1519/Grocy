//
//  LocationManagerTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//
import Foundation
import Testing
@testable @preconcurrency import Grocy
import CoreLocation

struct LocationManagerTests {

    @Test func testLocationManagerUpdatesLocation() async throws {
        let locationManager = LocationManager()

        // Simulate a location update
        let testLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)

        // Call the delegate method manually
        locationManager.locationManager(locationManager.manager, didUpdateLocations: [testLocation])

        // Wait for the async task inside `didUpdateLocations` to complete
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2 seconds

        #expect(locationManager.location?.coordinate.latitude == 37.7749)
        #expect(locationManager.location?.coordinate.longitude == -122.4194)
    }

    
    @Test func testReverseGeocodeSuccess() async throws {
        let locationManager = LocationManager()
        let testLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)

        await locationManager.reverseGeocode(location: testLocation)
        try await Task.sleep(nanoseconds: 500_000_000) // wait a bit

        #expect(locationManager.address.contains("San Francisco"))
    }



    @Test func testReverseGeocodeFailure() async throws {
        let locationManager = LocationManager()
        let failedLocation = CLLocation(latitude: 0, longitude: 0)

        await locationManager.reverseGeocode(location: failedLocation)
        try await Task.sleep(nanoseconds: 500_000_000)

        #expect(locationManager.address == "")
    }

    
    @Test func testLocationManagerFailWithError() async throws {
        let locationManager = LocationManager()

        let mockError = NSError(domain: "com.grocy", code: 999, userInfo: [NSLocalizedDescriptionKey: "Location not found"])

        // Simulate location failure
        locationManager.locationManager(locationManager.manager, didFailWithError: mockError)

        // Wait for the async address update on MainActor
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2 seconds

        #expect(locationManager.address == "Location not Found")
    }


}
