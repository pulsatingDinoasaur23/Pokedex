//
//  HomemoduleEntity.swift
//  Pokedex
//
//  Created by michaell medina on 17/01/24.
//

import Foundation

struct PokemonCardDetails: Codable{
    var name: String
    var imageDataFront: Data?
    var imageDataBack:Data?
    let types: [TypeElement]
    let stats: [Stat]
}

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}
struct Pokemon: Codable {
    let name: String
    let url: String
}
struct PokemonCellsDetails: Codable{
    let name: String
    let id: Int
    let sprites: Sprites?
    let types: [TypeElement]
    let stats: [Stat]
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case sprites
        case types
        case stats
    }
}

struct Sprites: Codable {
    let frontDefault: String?
    let backDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species?
}

struct Species: Codable {
    let name: String
    let url: String
}

struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
