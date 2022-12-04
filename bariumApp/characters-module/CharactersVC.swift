//
//  CharactersVC.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 27.11.2022.
//

import UIKit
import Kingfisher

class CharactersVC: UIViewController {
    
    var characterList = [Character]()
    var isLoading = false

    @IBOutlet weak var CharacterCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CharacterCollectionView.delegate = self
        CharacterCollectionView.dataSource = self
        
        
        CharacterCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
        
        getCharacters()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toCharDetail":
            let goalVC = segue.destination as! CharacterDetailVC
            if let payload = sender as? Character{
                goalVC.character = payload
            }
            
        default:
            print("identifier Not Found")
        }
    }
    
}

extension CharactersVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCollectionViewCell
        let obj = characterList[indexPath.row]
        cell?.bigLabel.text = obj.nickname
        cell?.subLabel.text = obj.name
        cell?.miniLabel.text = obj.birthdate
        
        if let url = URL(string: (obj.imageURL)!){
                 DispatchQueue.main.async {
                     cell?.imageOutlet.kf.setImage(with: url, placeholder: UIImage(named: "no-poster"))
                 }
             }
        
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characterList[indexPath.row]
        performSegue(withIdentifier: "toCharDetail", sender: character)
    }
    
    
}
