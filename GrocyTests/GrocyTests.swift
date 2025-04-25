//
//  GrocyTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//
import Foundation
import Testing
@testable import Grocy

struct GrocyTests {
    
    // MARK: - Main App Tests
    
    @Test
    func splashScreenAppearsOnLaunch() {
        
        let app = GrocyApp()
        
        assert(app.showSplashScreen, "Splash screen should be visible on launch")
    }
    
    @Test
    func userDataLoadsOnLaunch() async  throws{
        let user = DataModel()
        
        
        try? await user.loadUserData()
        
        assert(user.users.count >= 0, "User data should load successfully")
    }
    
    @Test
    func correctViewAppearsBasedOnLoginState() {
        let user = DataModel()
        user.isLoggedIn = true  // Simulate logged-in state
        
        let app = GrocyApp(user: user)  // Pass user instance to the app
        
        #expect(app.user.isLoggedIn, "User should be marked as logged in")
        assert(type(of: ContentView(user: user)) == ContentView.self, "App should show content view for logged-in user")
    }
    
    
    @Test
    func splashScreenRestoresOnBackground() {
        
        let app = GrocyApp()
        
        app.isAppInBackground = true
        
        assert(app.showSplashScreen, "Splash screen should reappear when app goes into the background")
    }
    
    
    // MARK: - User Tests
    @Test func testUserIsSignUpDataValid() {
        var user = User.example
        user.name = "John Doe"
        user.email = "john@example.com"
        user.phone = "9876543210"
        user.password = "password123"
        
        // Test valid data
        #expect(user.isSignUpDataValid == true)
        
        // Test invalid data (empty name)
        user.name = ""
        #expect(user.isSignUpDataValid == false)
        
        // Test invalid data (invalid phone number)
        user.phone = "1234"
        #expect(user.isSignUpDataValid == false)
    }
    
    @Test func testUserPhoneValidation() {
        var user = User.example
        
        // Valid phone number
        user.phone = "9876543210"
        #expect(user.isValidPhoneNumber == true)
        
        // Invalid phone number (too short)
        user.phone = "12345"
        #expect(user.isValidPhoneNumber == false)
        
        // Invalid phone number (invalid format)
        user.phone = "123456789"
        #expect(user.isValidPhoneNumber == false)
    }
    
    @Test func testUserSortedOrdersByDate() {
        var user = User.example
        let order1 = Order(id: UUID(), date: Date().addingTimeInterval(-86400)) // 1 day ago
        let order2 = Order(id: UUID(), date: Date()) // today
        
        user.orders = [order1, order2]
        
        let sortedOrders = user.sortedOrdersByDate
        #expect(sortedOrders.first?.id == order2.id)
        #expect(sortedOrders.last?.id == order1.id)
    }
    
    @Test func testUserPrimaryAddress() {
        var user = User.example
        
        // Test default address
        let defaultAddress = user.primaryAddress
        #expect(defaultAddress.addressType == "Home")
        
        // Test setting a new primary address
        let newAddress = UserAddress(
            name: "John Doe", email: "john@example.com", phone: "9876543210", city: "City", state: "State", country: "Country",
            district: "District", street: "Street", pincode: "12345", landmark: "Landmark", addressType: "Home"
        )
        user.primaryAddress = newAddress
        #expect(user.primaryAddress == newAddress)
    }
    
    @Test func testUserCanPlaceOrder() {
        var user = User.example
        
        // Test when address is invalid (invalid phone number)
        user.phone = "1234"
        #expect(user.canPlaceOrder == false)
        
        // Test when address is valid
        user.phone = "9876543210"
        let validAddress = UserAddress(
            name: "John Doe", email: "john@example.com", phone: "9876543210", city: "City", state: "State", country: "Country",
            district: "District", street: "Street", pincode: "123455", landmark: "Landmark", addressType: "Home"
        )
        user.primaryAddress = validAddress
        #expect(user.canPlaceOrder == true)
    }
    
    
    @Test func testUserEquality() {
        let user1 = User.example
        let user2 = User.example
        
        // Test equality between two identical users
        #expect(user1 == user2)
        
        // Test inequality (different emails)
        var user3 = user1
        user3.email = "newemail@example.com"
        
        #expect(user1 != user3)
    }
   
}
