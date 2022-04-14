//
//  CharacterCollectionViewCell.swift
//  StarWarsCardGame
//
//  Created by Tasuku Yamamoto on 4/14/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var characterImageView: UIImageView!
    
    //MARK: - Helper Methods
    func displayImage(for character: Character){
        characterImageView.image = character.photo
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
    }
    
}
