//
//  ApiHandler.swift
//  PokeApp
//
//  Created by IOS SENAC on 10/16/21.
//

import Foundation
import Alamofire

class APIHandler {
        
    var statusCode = Int.zero
    
    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            return response.value
        case .failure:
            return nil
        }
    }
}
