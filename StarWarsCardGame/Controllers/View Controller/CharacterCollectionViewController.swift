//
//  CharacterCollectionViewController.swift
//  StarWarsCardGame
//
//  Created by Tasuku Yamamoto on 4/14/22.
//

import UIKit

class CharacterCollectionViewController: UICollectionViewController {
    //MARK: - Properties
    private var displayedCharacters: [Character] = []
    private var targetCharacter: Character?
    private var selectedFaction = "jedi"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCharacters(for: selectedFaction)
    }
    
    //MARK: - Helper Methods
    func shuffleCharacters(for faction: String){
        if faction == "jedi"{
            CharacterController.jedi.shuffle()
            let jediGroup = CharacterController.jedi.prefix(3)
            displayedCharacters = Array(jediGroup)
            targetCharacter = CharacterController.sith.randomElement()
        }else if faction == "sith"{
            CharacterController.sith.shuffle()
            let sithGroup = CharacterController.sith.prefix(3)
            displayedCharacters = Array(sithGroup)
            targetCharacter = CharacterController.jedi.randomElement()
        }
        updateViews()
    }
    
    func updateViews() {
        guard let character = targetCharacter else { return }
        displayedCharacters.append(character)
        displayedCharacters.shuffle()
        title = "Find \(character.name)"
        collectionView.reloadData()
    }
    
    func presentAlert(for character: Character) {
        let success = character == targetCharacter
        let alertController = UIAlertController(title: success ? "Good Job!" : "Better luck next time", message: nil, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let suffleAction = UIAlertAction(title: "Shuffle!", style: .default) { _ in
            self.shuffleCharacters(for: self.selectedFaction)
        }
        alertController.addAction(doneAction)
        
        if success {
            alertController.addAction(suffleAction)
        }
        
        present(alertController, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterVC" {
            let vc = segue.destination as? FilterViewController
            vc?.delegate = self
        }
    }
    

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedCharacters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //type casting from a UICollectionViewCell to CharacterCollectionViewCell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell()}
        
        let character = displayedCharacters[indexPath.row]
        cell.displayImage(for: character)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = displayedCharacters[indexPath.row]
        presentAlert(for: character)
    }
}

extension CharacterCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 15, height: width + 30)
    }
}

extension CharacterCollectionViewController: FilterSelectionDelegate{
    func selected(faction: String) {
        selectedFaction = faction
        shuffleCharacters(for: selectedFaction)
    }
}
