//
//  CaracterTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Ярослав Кочкин on 02.10.2023.
//

import UIKit
import Kingfisher

final class CaracterCell: UITableViewCell {
    
    @IBOutlet var characrerImage: UIImageView!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var aliveLable: UILabel!
    @IBOutlet var viewCell: UIView!
    @IBOutlet var aliveView: UIView!
    
    private let networkMenager = NetworkManager.shared

    override func awakeFromNib() {
        super.awakeFromNib()
        settingView()
    }
    
    func configure(with character: Results) {
        costomizeViewColor(status: character.status)
        nameLable.text = character.name
        aliveLable.text = character.status
        feach(image: character.image)
    }
}


private extension CaracterCell {
    func settingView() {
        viewCell.layer.shadowOpacity = 0.5
        viewCell.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        viewCell.layer.shadowRadius = 10
    }
    
    func costomizeViewColor(status: String) {
        switch status {
        case "Alive":
            aliveView.backgroundColor = .green
        case "Dead":
            aliveView.backgroundColor = .red
        default:
            aliveView.backgroundColor = .gray
        }
    }
    
    func feach(image: String) {
        let url = URL(string: image)
        let processor = DownsamplingImageProcessor(size: characrerImage.bounds.size)
        characrerImage.kf.indicatorType = .activity
        characrerImage.kf.setImage(
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
