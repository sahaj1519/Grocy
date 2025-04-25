//
//  UserAddressTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//
import Foundation
import Testing
@testable import Grocy

struct UserAddressTests {

   
    @Test func testValidPincode() {
            let valid = UserAddress.example.with(pincode: "110092")
            let invalid = valid.with(pincode: "1234")
            
            #expect(valid.isValidPincode)
            #expect(!invalid.isValidPincode)
        }
        
        @Test func testValidPhoneNumber() {
            let valid = UserAddress.example.with(phone: "9876543210")
            let invalid = valid.with(phone: "1234567890")
            
            #expect(valid.isValidPhoneNumber)
            #expect(!invalid.isValidPhoneNumber)
        }
        
        @Test func testHasValidAddress() {
            let valid = UserAddress.example
            let invalid = valid.with(city: "")
            
            #expect(valid.hasValidAddress)
            #expect(!invalid.hasValidAddress)
        }
        
        @Test func testIsComplete() {
            let complete = UserAddress.example
            let incomplete = complete.with(name: "")
            
            #expect(complete.isComplete)
            #expect(!incomplete.isComplete)
        }
        
        @Test func testUserAddressEquality() {
            let id = UUID()
            let user1 = UserAddress.example.with(id: id)
            let user2 = UserAddress.example.with(id: id)
            let user3 = user1.with(email: "diff@example.com") // still equal if ID same
            
            #expect(user1 == user2)
            #expect(user1 == user3)
        }

}
