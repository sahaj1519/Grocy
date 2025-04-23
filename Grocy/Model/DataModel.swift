//
//  DataModel.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//
import SwiftUI
import Foundation

@Observable
class DataModel: Codable {
    
    var optionalUser: User? = .example
    var users: [User] = []
    var isLoggedIn: Bool = false
    
    private let loggedInKey = "loggedIn"
    private let loggedInUserEmailKey = "loggedInEmail"

    
    enum CodingKeys: String, CodingKey {
        case _optionalUser = "optionalUser"
        case _users = "users"
        case _isLoggedIn = "isLoggedIn"
    }
    
    var currentUser: User {
            get {
                optionalUser ?? User(name: "", email: "", phone: "", orders: [], address: [])
            }
            set {
                optionalUser = newValue
            }
        }
        
    
    func getFileURL() -> URL {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("Users.json")
    }
    
    
    
    func saveUserData() async throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        // Find the index of the currently logged-in user and update the password
        if let loggedInUser = optionalUser {
            if let index = users.firstIndex(where: { $0.email == loggedInUser.email }) {
                users[index] = loggedInUser // Update the user in the users array
            }
        }

        // Now save the updated users list
        let data = try encoder.encode(self.users)
        let fileURL = getFileURL()
        try data.write(to: fileURL)
    }

    
    // Load user data from the file.
    func loadUserData() async throws {
        let fileURL = getFileURL()
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        
        let savedUsers = try decoder.decode([User].self, from: data)
        self.users = savedUsers

        // Restore login state from UserDefaults
        if UserDefaults.standard.bool(forKey: loggedInKey),
           let savedEmail = UserDefaults.standard.string(forKey: loggedInUserEmailKey),
           let matchedUser = savedUsers.first(where: { $0.email == savedEmail }) {
            self.optionalUser = matchedUser
            self.isLoggedIn = true
        }
    }

    
    
    func removeOrder(_ order: Order) {
        guard var currentUser = optionalUser else { return }
        currentUser.orders.removeAll { $0.id == order.id }
        optionalUser = currentUser  // Set the updated user back to optionalUser
    }


    
    func userAlreadyExists(_ newUser: User) async -> Bool {
        do {
            let fileURL = getFileURL()
            guard FileManager.default.fileExists(atPath: fileURL.path) else { return false }

            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let savedUsers = try decoder.decode([User].self, from: data)
            
            return savedUsers.contains { $0.email.lowercased() == newUser.email.lowercased() }
        } catch {
            return false
        }
    }

    
    func logout() {
        // Clear the optional user and logout state
        self.optionalUser = nil
        self.isLoggedIn = false
        
        // Remove the login state from UserDefaults
        UserDefaults.standard.removeObject(forKey: loggedInKey)
        UserDefaults.standard.removeObject(forKey: loggedInUserEmailKey)
        
        // Save the users data without altering the existing user list
        Task {
            do {
                try await saveUserData() // Save the existing users without the logged-out user
            } catch {
                print("Error saving user data after logout: \(error)")
            }
        }
    }

    
    // Add a new user and save it to the users list.
    func addUser(_ user: User) {
        self.users.append(user)
        self.optionalUser = user
        self.isLoggedIn = true
        
        // Save login state to UserDefaults
        UserDefaults.standard.set(true, forKey: loggedInKey)
        UserDefaults.standard.set(user.email, forKey: loggedInUserEmailKey)
        
        Task {
            try? await saveUserData()
        }
    }
    
    func loadCurrentUser() {
        // Load user data from storage (e.g., UserDefaults or a file)
        if let savedUserData = UserDefaults.standard.data(forKey: "currentUser") {
            if let decodedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
                self.currentUser = decodedUser
            }
        }
    }

    
    static var preview: DataModel {
        let model = DataModel()
        model.optionalUser = User(
            id: UUID(),
            name: "John Akia Rom",
            email: "akia@example.com",
            password: "password",
            phone: "1234567890",
            orders: [],
            favorite: nil,
            cart: nil,
            address: []
        )
        model.isLoggedIn = true
        return model
    }

}
