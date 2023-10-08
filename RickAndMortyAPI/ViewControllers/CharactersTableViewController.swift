//
//  CharactersTableViewController.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 02.10.2023.
//

import UIKit
import Kingfisher

final class CharactersTableViewController: UITableViewController {
    
    private var characters: [Results] = []
    private let networkManager = NetworkManager.shared
    private let searchController = UISearchController(searchResultsController: nil)


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 115
        setupSearchController()
        feachCharacters()
        setupRefreshControl()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoVC = segue.destination as? CharacterInfoViewController
        infoVC?.character = sender as? Results
    }
    
    @IBAction func clearCache(_ sender: UIBarButtonItem) {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
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

// MARK: - UISearchResultsUpdating
extension CharactersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
    }
}


extension CharactersTableViewController {
    @objc private func feachCharacters() {
//        let urlCharacters = RickAndMortyAPI.characters.rawValue + String(Int.random(in: 1...42))
        networkManager.feachCharacterAF(
            from: "https://rickandmortyapi.com/api/character?page=\(Int.random(in: 1...42))") { [weak self] results in
                switch results {
                case .success(let characters):
                    self?.characters = characters
                    self?.tableView.reloadData()
                    if self?.refreshControl != nil {
                        self?.refreshControl?.endRefreshing()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(feachCharacters), for: .valueChanged)
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .purple
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
}
