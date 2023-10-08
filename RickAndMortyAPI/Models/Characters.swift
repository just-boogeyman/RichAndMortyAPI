//
//  Character.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 01.10.2023.
//



struct Characters: Decodable {
    let info: Info
    let results: [Results]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String
}

struct Results: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let location: Location
    let origin: Location
    
    init(characterData: [String: Any]) {
        id = characterData["id"] as? Int ?? 0
        name = characterData["name"] as? String ?? "Rick"
        status = characterData["status"] as? String ?? "Alive"
        species = characterData["species"] as? String ?? "Alien"
        image = characterData["image"] as? String ?? "image"
        
        let locationDict = characterData["location"] as? [String: String] ?? [:]
        location = Location(value: locationDict)
        
        let originDict = characterData["origin"] as? [String: String] ?? [:]
        origin = Location(value: originDict)
    }
    
    static func getCharacters(from value: Any) -> [Results] {
        guard let charachersData = value as? [String: Any] else { return [] }
        guard let results = charachersData["results"] as? [[String: Any]] else { return [] }
        return results.map { Results(characterData: $0) }
    }
}

struct Location: Decodable {
    let name: String
    
    init(value: [String: String]) {
        name = value["name"] ?? "123"
    }
}

