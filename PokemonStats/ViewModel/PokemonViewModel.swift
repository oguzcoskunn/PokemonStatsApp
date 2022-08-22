//
//  Model.swift
//  PokeTask
//
//  Created by Oğuz Coşkun on 19.08.2022.
//

import SwiftUI



class PokemonViewModel: ObservableObject {
    @Published var PokemonStat = PokemonStats(name: "", imageUrl: "", hp: 0, attack: 0, defense: 0)
    @Published var statusLoading: Bool = false

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    init(pokemonId: Int) {
        getPokemon(with: String(pokemonId))
    }
    
    func getPokemon(with searchText: String) {
        let requestURL = baseURL.appendingPathComponent(searchText)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"

        self.statusLoading = true
        
        getPokemonStat(request: request)
    }
    
    func getPokemonStat(request: URLRequest) {
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching pokemon: \(error)")
                return
            }

            guard let data = data else { return }
            
            do {
                let pokeStats = try JSONDecoder().decode(AllStats.self, from: data)
                let allstats = pokeStats.stats
                
                DispatchQueue.main.async {
                    self.PokemonStat.name = pokeStats.name
                    self.PokemonStat.hp = allstats[0].base_stat
                    self.PokemonStat.attack = allstats[1].base_stat
                    self.PokemonStat.defense = allstats[2].base_stat
                    self.PokemonStat.imageUrl = pokeStats.sprites.front_default
                    self.statusLoading = false
                }
                
            } catch {
                print("Error decoding Pokemon: \(error)")
                return
            }
        }.resume()
    }
}
 
