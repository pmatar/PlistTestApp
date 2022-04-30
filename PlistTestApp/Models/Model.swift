//
//  Model.swift
//  PlistTestApp
//
//  Created by Paul Matar on 29/04/2022.
//

import Foundation


struct Plist: Codable {
    var scheme: [Item]
    var data: [Person]
}

struct Item: Codable {
    let id: String
    let type: String
    let title: String
    let required: Bool
}

struct Person: Codable {
    var childrenCount: String?
    var birthdate: String?
    var lastName: String?
    var name: String?
}
