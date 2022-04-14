//
//  FilterViewController.swift
//  StarWarsCardGame
//
//  Created by Tasuku Yamamoto on 4/14/22.
//

import UIKit

protocol FilterSelectionDelegate: AnyObject {
    func selected(faction: String)
}

class FilterViewController: UIViewController {
    //MARK: - Properties
    weak var delegate: FilterSelectionDelegate?
    
    //MARK: - IBActions
    @IBAction func sithButtonTapped(_ sender: Any) {
        delegate?.selected(faction: "sith")
        self.dismiss(animated: true)
    }
    
    @IBAction func jediButtonTapped(_ sender: Any) {
        delegate?.selected(faction: "jedi")
        self.dismiss(animated: true)
    }
}
