//
//  DataTask.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 01.10.2023.
//

import Foundation

enum RickAndMortyAPI: String {
    case characters = "https://rickandmortyapi.com/api/character"
    case locations = "https://rickandmortyapi.com/api/location"
    case episodes = "https://rickandmortyapi.com/api/episode"
}


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func feachCharacters(from url: String, complition: @escaping(Result<Characters, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            complition(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                complition(.failure(.noData))
                return
            }
            
            do {
                let characters = try JSONDecoder().decode(Characters.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(characters))
                }
            } catch {
                complition(.failure(.decodingError))
            }
        }.resume()
    }
    
    func feachImage(from url: String, complition: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            complition(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                complition(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                complition(.success(imageData))
            }
        }
    }
}
