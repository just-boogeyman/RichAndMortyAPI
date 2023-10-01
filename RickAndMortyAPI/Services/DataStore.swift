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

final class DataStore {
    
    static let shared = DataStore()
    
    func feachCharacters() {
        guard let url = URL(string: RickAndMortyAPI.characters.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No date")
                return
            }
            
            do {
                let info = try JSONDecoder().decode(Characters.self, from: data)
                print(info)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    private init() {}
}
