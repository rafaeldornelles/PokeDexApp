//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by IOS SENAC on 10/16/21.
//

import Foundation
import Combine

class PokemonViewModel: ObservableObject, Identifiable {
    var handler = PokemonHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var pokemonUrl: String
    
    @Published var pokemon: Pokemon? = nil
    @Published var isLoading = false
    @Published var image: Data?
    
    private var pokemonPublisher: AnyPublisher<Pokemon?, Never>{
        handler.$pokemon
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private var isLoadingPublisher: AnyPublisher<Bool, Never>{
        handler.$isLoading
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private var imagePublisher: AnyPublisher<Data?, Never>{
        handler.$image
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    init(pokemonUrl: String) {
        self.pokemonUrl = pokemonUrl
        
        pokemonPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.pokemon, on: self)
            .store(in: &disposables)
        
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)
        
        imagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &disposables)
        
        handler.fetchPokemon(url: self.pokemonUrl)
    }
    
    
}
