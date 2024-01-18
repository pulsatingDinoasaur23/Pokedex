//
//  HomeExternalDataManager.swift
//  Pokedex
//
//  Created by michaell medina on 17/01/24.
//

import Foundation

class HomeExternalDataManager: HomeExternalDataManagerProtocol {
    var interactorOutputProtocol: HomeModuleInteractorOutputProtocol?
    var pokemonList = [PokemonListResponse]()
    var pokemonImages = [PokemonCellsDetails]()
    func fetchPokemonList(completion: @escaping () -> Void) {
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/")!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let pokemonList = try decoder.decode(PokemonListResponse.self, from: data)
                self.pokemonList = [pokemonList]
                fetchPokemonDetails(pokemonCard: pokemonList) { pokemons, _  in
                    self.pokemonImages = pokemons
                    completion()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
    private func fetchPokemonDetails(pokemonCard: PokemonListResponse, completion: @escaping ([PokemonCellsDetails], [Pokemon]) -> Void) {
        var pokemons: [PokemonCellsDetails] = []
        var pokemonsData: [Pokemon] = []
        let group = DispatchGroup()
        pokemonCard.results.forEach { pokemon in
            var request = URLRequest(url: URL(string: pokemon.url)!)
            request.httpMethod = "GET"
            group.enter()
            URLSession.shared.dataTask(with: request) { data, response, error in
                defer {
                    group.leave()
                }
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let pokemonDetails = try decoder.decode(PokemonCellsDetails.self, from: data)
                    pokemons.append(pokemonDetails)
                    pokemonsData.append(Pokemon(name: pokemonDetails.name, url: pokemon.url))
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
        }
        group.notify(queue: DispatchQueue.main) {
            self.interactorOutputProtocol?.onPokemonImageRetrieved(pokemons, pokemonsData)
            completion(pokemons, pokemonsData)
        }
    }
}
