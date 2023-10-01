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
}
