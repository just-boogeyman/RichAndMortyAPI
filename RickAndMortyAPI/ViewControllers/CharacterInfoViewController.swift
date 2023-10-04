//
//  CharacterInfoViewController.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 04.10.2023.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var statusLable: UILabel!
    @IBOutlet var speciesLable: UILabel!
    @IBOutlet var locationLable: UILabel!
    @IBOutlet var originLable: UILabel!
    
    @IBOutlet var statusView: UIView!
    @IBOutlet var lineStatusView: UIView!
    @IBOutlet var characterView: UIView!
    
    var character: Results!
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        configure()
    }
    
    func configure() {
        guard let character else { return }
        title = character.name
        statusLable.text = character.status
        speciesLable.text = character.species
        locationLable.text = character.location.name
        originLable.text = character.origin.name
        
        switch character.status {
        case "Alive":
            statusView.backgroundColor = .green
            lineStatusView.backgroundColor = .green
            characterView.layer.shadowColor = UIColor.green.cgColor
        case "Dead":
            statusView.backgroundColor = .red
            lineStatusView.backgroundColor = .red
            characterView.layer.shadowColor = UIColor.red.cgColor
        default:
            statusView.backgroundColor = .gray
            lineStatusView.backgroundColor = .gray
            characterView.layer.shadowColor = UIColor.gray.cgColor

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
    
    private func settingView() {
        characterView.layer.shadowOpacity = 0.3
        characterView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        characterView.layer.shadowRadius = 20
        statusView.layer.shadowOpacity = 0.5
        statusView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        statusView.layer.shadowRadius = 10
        lineStatusView.layer.shadowOpacity = 0.7
        lineStatusView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        lineStatusView.layer.shadowRadius = 7
    }
}
