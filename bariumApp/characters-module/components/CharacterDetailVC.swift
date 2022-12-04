//
//  CharactarDetailVC.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 27.11.2022.
//

import UIKit

class CharacterDetailVC: UIViewController {
    
    var character : Character?

    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var detailLabelOne: UILabel!
    
    @IBOutlet weak var detailLabelTwo: UILabel!
    
    @IBOutlet weak var quotesButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageOutlet.layer.cornerRadius = 12
        
        if let url = URL(string: (character?.imageURL)!){
                 DispatchQueue.main.async {
                     self.imageOutlet.kf.setImage(with: url, placeholder: UIImage(named: "no-poster"))
                 }
             }
        
        mainLabel.text = character?.nickname
        subLabel.text = character?.name
        detailLabelOne.text = character?.occupation
        
        detailLabelTwo.text = "Portrayed by \(character?.portrayedBy ?? "Unknown Actor")"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toCharQuotes":
            let goalVC = segue.destination as! CharacterQuotesVC
            if let payload = sender as? String{
                goalVC.charName = payload
            }
            
        default:
            print("identifier Not Found")
        }
    }
    
    @IBAction func quotesAction(_ sender: Any) {
        performSegue(withIdentifier: "toCharQuotes", sender: character?.name)
    }
    
}
