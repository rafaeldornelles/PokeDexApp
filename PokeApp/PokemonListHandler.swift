//
//  PokemonHandler.swift
//  PokeApp
//
//  Created by IOS SENAC on 10/16/21.
//

import Foundation
import Alamofire
import Combine

class PokemonListHandler: APIHandler{
    @Published var count: Int = 0
    @Published var next: String?
    @Published var results = [PokemonListResult]()
    
    @Published var isLoading = false
    
    private var path = "https://pokeapi.co/api/v2/pokemon/"
    
    func loadList(){
        isLoading = true
        let request = AF.request(path)
        request.responseDecodable{ [weak self] (response: DataResponse<pokemonList, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? pokemonList else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.isLoading = false
            
            if let results = response.results {
                weakSelf.results = results
            }
            if let count = response.count{
                weakSelf.count = count
            }
            if let next = response.next{
                weakSelf.next = next
            }
        }
    }
    
    func loadNextPage(){
        if next == nil { return }
        isLoading = true
        let request = AF.request(next!)
        request.responseDecodable{ [weak self] (response: DataResponse<pokemonList, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? pokemonList else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.isLoading = false
            if let results = response.results{
                weakSelf.results.append(contentsOf: results)
            }
            weakSelf.next = response.next //Nao verifica se é nulo pois se for nulo é pq não tem mais resultados para carregar
        }
    }
    
}


