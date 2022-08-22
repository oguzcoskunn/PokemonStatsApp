//
//  Model.swift
//  PokeTask
//
//  Created by Oğuz Coşkun on 21.08.2022.
//

import SwiftUI

struct PokemonStats {
    var name: String
    var imageUrl: String
    var hp: Int
    var attack: Int
    var defense: Int
}

struct Stat: Codable {
    var base_stat: Int
}

struct ImageUrl: Codable {
    var front_default: String
}

struct AllStats: Codable {
    var name: String
    var stats: [Stat]
    var sprites: ImageUrl
}
