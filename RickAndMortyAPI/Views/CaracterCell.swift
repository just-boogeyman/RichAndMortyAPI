//
//  CaracterTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 02.10.2023.
//

import UIKit

final class CaracterCell: UITableViewCell {
    
    @IBOutlet var characrerImage: UIImageView!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var aliveLable: UILabel!
    @IBOutlet var viewCell: UIView!
    @IBOutlet var aliveView: UIView!
    private let natworkMenager = NetworkManager.shared

    override func awakeFromNib() {
        super.awakeFromNib()
        settingView()
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
    
    private func settingView() {
        viewCell.layer.shadowOpacity = 0.5
        viewCell.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        viewCell.layer.shadowRadius = 10
    }
}
