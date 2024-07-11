//
//  NetworkManager.swift
//  TestApiWithAlamoFire
//
//  Created by Egor Ukolov on 11.07.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let characterURL = "https://rickandmortyapi.com/api/character/507"
    
    func fetchCharacter(completion: @escaping (Result<Character, Error>) -> Void ) {
        
        AF.request(characterURL)
            .validate()
            .responseData { response in
                
                switch response.result {
                case .success(let data):
                    
                    do {
                        let character = try JSONDecoder().decode(Character.self, from: data)
                        completion(.success(character))
                        
                    } catch let error {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
