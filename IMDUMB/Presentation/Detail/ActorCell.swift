//
//  ActorCell.swift
//  IMDUMB
//
//  Created by Derly on 27/04/26.
//

import UIKit

class ActorCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .darkGray
        layer.cornerRadius = 8
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 11)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
    }
    
    func configure(with actor: Actor) {
        nameLabel.text = actor.name
    }
}
