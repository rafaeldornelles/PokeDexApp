//
//  Pokemon.swift
//  PokeApp
//
//  Created by IOS SENAC on 10/16/21.
//

import Foundation

class Pokemon: Decodable, Identifiable{
    var id: Int?
    var name: String?
    var baseExperience: Int?
    var height: Int?
    var sprite: Sprites?
    
    
    init() { }
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case base_experience
        case height
        case sprites
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        baseExperience = try? container.decode(Int.self, forKey: .base_experience)
        height = try? container.decode(Int.self, forKey: .height)
        sprite = try? container.decode(Sprites.self, forKey: .sprites)
    }
}


class Sprites: Decodable, Identifiable{
    var frontDefault: String?
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case front_default
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        frontDefault = try? container.decode(String.self, forKey: .front_default)
    }
}

class pokemonList: Decodable, Identifiable{
    var count: Int?
    var next: String?
    var previous: String?
    var results: [PokemonListResult]?
    
    init() {    }
    
    enum CodingKeys: String, CodingKey{
        case count
        case next
        case previous
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        count = try? container.decode(Int.self, forKey: .count)
        next = try? container.decode(String.self, forKey: .next)
        previous = try? container.decode(String.self, forKey: .previous)
        results = try? container.decode([PokemonListResult].self, forKey: .results)
    }
}

class PokemonListResult: Decodable, Identifiable{
    var name: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey{
        case name
        case url
    }
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try? container.decode(String.self, forKey: .name)
        url = try? container.decode(String.self, forKey: .url)
    }
}
