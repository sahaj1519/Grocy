//
//  DataModel.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import Foundation

@Observable
class DataModel: Codable {
    
    var currentUser: User = .example
    
    func getFileURL() -> URL {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("User.json")
    }
    
    func saveUserData() async throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try encoder.encode(currentUser)
        
        let fileURL = getFileURL()
        
        try data.write(to: fileURL)
    }
    
    func loadUserData() async throws {
        
        let fileURL = getFileURL()
        let data = try Data(contentsOf: fileURL)
        
        let decoder = JSONDecoder()
        
        currentUser = try decoder.decode(User.self, from: data)
       
    }
    
    static var preview: DataModel {
        let model = DataModel()
        model.currentUser = User(
            id: UUID(),
            name: "john akia rom",
            email: "akia@example.com",
            phone: "1234567890",
            orders: [],
            favorite: nil,
            cart: nil,
            address: []
            )
        return model
    }

}
