//
//  CharacterCollectionViewCell.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 27.11.2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var bigLabel: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var miniLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageOutlet.layer.cornerRadius = 6
    }

}
