//
//  CaracterTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 02.10.2023.
//

import UIKit

enum StatusCharacter: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

final class CaracterCell: UITableViewCell {
    
    
    @IBOutlet var characrerImage: UIImageView!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var aliveLable: UILabel!
    
    @IBOutlet var aliveView: UIView!
    private let natworkMenager = NetworkManager.shared

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with character: Results) {
        switch character.status {
        case "Alive":
            aliveView.backgroundColor = .green
        case "Dead":
            aliveView.backgroundColor = .red
        default:
            aliveView.backgroundColor = .gray
        }
        nameLable.text = character.name
        aliveLable.text = character.status
        natworkMenager.feachImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characrerImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
