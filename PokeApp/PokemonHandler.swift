//
//  PokemonHandler.swift
//  PokeApp
//
//  Created by IOS SENAC on 10/16/21.
//

import Foundation
import Combine
import Alamofire

class PokemonHandler: APIHandler{
    @Published var pokemon: Pokemon?
    
    @Published var isLoading = false
    
    @Published var image: Data?
    
    
    func fetchPokemon(url: String){
        isLoading = true
        let request = AF.request(url)
        request.responseDecodable{ [weak self] (response: DataResponse<Pokemon, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? Pokemon else {
                weakSelf.isLoading = false
                return
            }
            if let imageUrl = response.sprite?.frontDefault{
                weakSelf.loadImageData(url: imageUrl)
            }else{
                weakSelf.isLoading = false
            }
            weakSelf.pokemon = response
        }
    }
    
    func loadImageData(url: String){
        isLoading = true
        let request = AF.request(url)
        request.responseData{ response in
            self.image = response.data
            self.isLoading = false
        }
    }
}
