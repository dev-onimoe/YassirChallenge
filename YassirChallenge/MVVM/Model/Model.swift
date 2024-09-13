//
//  Model.swift
//  YassirChallenge
//
//  Created by Masud Onikeku on 10/09/2024.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Character
struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationInfo
    let location: LocationInfo
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - LocationInfo
struct LocationInfo: Codable {
    let name: String
    let url: String
}
