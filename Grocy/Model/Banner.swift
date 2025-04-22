//
//  Banner.swift
//  Grocy
//
//  Created by Ajay Sangwan on 22/04/25.
//

import Foundation

struct Banner: Identifiable, Hashable, Codable {
    var id = UUID()
    let imageURL: URL
}
