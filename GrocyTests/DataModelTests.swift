//
//  DataModelTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable @preconcurrency import Grocy

struct DataModelTests {

    
    @Test func testUserLoginAndLogoutFlow() async throws {
        let model = DataModel()
        let user = User(id: UUID(), name: "Test", email: "test@example.com", password: "1234", phone: "123456", orders: [], address: [])

        model.addUser(user)
        #expect(model.isLoggedIn == true)
        #expect(model.currentUser.email == "test@example.com")

        model.logout()
        // Delayed expectation as logout has async file save
        try await Task.sleep(nanoseconds: 500_000_000)
        #expect(model.isLoggedIn == false)
        #expect(model.optionalUser == nil)
    }

    @Test func testUserFileSaveAndLoad() async throws {
        let model = DataModel()
        let user = User(id: UUID(), name: "Test", email: "test@example.com", password: "1234", phone: "123456", orders: [], address: [])

        model.addUser(user)
        try await Task.sleep(nanoseconds: 200_000_000) // Give time for internal save to complete

        let newModel = DataModel()
        try await newModel.loadUserData()

        let exists = await newModel.userAlreadyExists(user)
        #expect(exists == true)
    }


    @Test func testRemoveOrderFromUser() {
        let user = User.example
        let orderToRemove = user.orders.first
        let model = DataModel()
        model.optionalUser = user

        if let order = orderToRemove {
            model.removeOrder(order)
            #expect(model.currentUser.orders.contains(where: { $0.id == order.id }) == false)
        }
    }
    
}
