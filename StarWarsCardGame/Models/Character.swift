//
//  Character.swift
//  StarWarsCardGame
//
//  Created by Tasuku Yamamoto on 4/14/22.
//

import UIKit

class Character {
    //MARK: - Properties
    let name: String
    let photo: UIImage?
    let faction: String
    
    //MARK: - Initializer
    init(name: String, photo: UIImage?, faction: String){
        self.name = name
        self.photo = photo
        self.faction = faction
    }
    
}//End of class

extension Character: Equatable{
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.name == rhs.name && lhs.photo == rhs.photo && lhs.faction == rhs.faction
    }
}
