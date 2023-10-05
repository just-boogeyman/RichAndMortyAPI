//
//  CharactersTableViewController.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 02.10.2023.
//

import UIKit

final class CharactersTableViewController: UITableViewController {
    
    private var characters: [Results] = []
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 115
        feachCharacters()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoVC = segue.destination as? CharacterInfoViewController
        infoVC?.character = sender as? Results
    }
}

// MARK: - Table view data source
extension CharactersTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CaracterCell else { return UITableViewCell() }
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        performSegue(withIdentifier: "goToInfoVC", sender: character)
    }
}


extension CharactersTableViewController {
    private func feachCharacters() {
        networkManager.feachCharacters(from: RickAndMortyAPI.characters.rawValue) { [weak self] result in
            switch result {
            case .success(let results):
                self?.characters = results.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
