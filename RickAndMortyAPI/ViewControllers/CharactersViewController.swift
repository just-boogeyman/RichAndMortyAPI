//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 01.10.2023.
//

import UIKit

final class CharactersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataStore.shared.feachCharacters()
    }
}

