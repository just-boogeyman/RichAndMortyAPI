//
//  CharacterInfoViewController.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 04.10.2023.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    

    private let networkManager = NetworkManager.shared
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var statusLable: UILabel!
    @IBOutlet var speciesLable: UILabel!
    @IBOutlet var locationLable: UILabel!
    
    @IBOutlet var statusView: UIView!
    
    @IBOutlet var lineStatusView: UIView!
    
    
    var character: Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        guard let character else { return }
        title = character.name
        statusLable.text = character.status
        speciesLable.text = character.species
        
        switch character.status {
        case "Alive":
            statusView.backgroundColor = .green
            lineStatusView.backgroundColor = .green
        case "Dead":
            statusView.backgroundColor = .red
            lineStatusView.backgroundColor = .red
        default:
            statusView.backgroundColor = .gray
            lineStatusView.backgroundColor = .gray
        }
                
        networkManager.feachImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
