//
//  CharacterInfoViewController.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 04.10.2023.
//

import UIKit
import Kingfisher

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
        settingViews()
        configure()
    }
}


//MARK: - Private Extensions
private extension CharacterInfoViewController {
    func configure() {
        guard let character else { return }
        title = character.name
        statusLable.text = character.status
        speciesLable.text = character.species
        locationLable.text = character.location.name
        originLable.text = character.origin.name
        costomizeViewColors(status: character.status)
        feach(image: character.image)
    }
    
    func settingViews() {
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
    
    func costomizeViewColors(status: String) {
        switch status {
        case "Alive":
            setupView(color: .green)
        case "Dead":
            setupView(color: .red)
        default:
            setupView(color: .gray)
        }
    }
    
    private func setupView(color: UIColor) {
        statusView.backgroundColor = color
        lineStatusView.backgroundColor = color
        characterView.layer.shadowColor = color.cgColor
    }
    
    func feach(image: String) {
        let url = URL(string: image)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        ) 
    }
}
