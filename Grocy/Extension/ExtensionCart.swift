//
//  ExtensionCart.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import Foundation

extension Cart {
    private static let userDefaultsKey = "SavedCart"

    func saveToUserDefaults() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: Self.userDefaultsKey)
        }
    }

    static func loadFromUserDefaults() -> Cart? {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let cart = try? JSONDecoder().decode(Cart.self, from: data) {
            return cart
        }
        return nil
    }

    static func clearFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
