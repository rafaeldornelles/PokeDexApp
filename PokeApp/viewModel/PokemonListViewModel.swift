//
//  PokemonListViewModel.swift
//  PokeApp
//
//  Created by IOS SENAC on 10/16/21.
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject, Identifiable{
    let pokemonListHandler = PokemonListHandler()
    @Published var isLoading = false
    @Published var count: Int = 0
    @Published var results = [PokemonListResult]()
    
    private var disposables: Set<AnyCancellable> = []

    private var isLoadingPublisher: AnyPublisher<Bool, Never>{
        pokemonListHandler.$isLoading
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private var countPublisher: AnyPublisher<Int, Never>{
        pokemonListHandler.$count
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private var resultsPublisher: AnyPublisher<[PokemonListResult], Never> {
        pokemonListHandler.$results
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    init() {
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)
        
        countPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.count, on: self)
            .store(in: &disposables)
        
        resultsPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.results, on: self)
            .store(in: &disposables)
        
        pokemonListHandler.loadList()
    }
    
    func nextPage(){
        pokemonListHandler.loadNextPage()
    }
    
}
