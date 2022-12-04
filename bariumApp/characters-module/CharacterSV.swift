//
//  CharacterSV.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 27.11.2022.
//

import Foundation

extension CharactersVC{
    
    func toggleLoading(){
        isLoading = !isLoading
        if(isLoading){
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
        }
        else{
            DispatchQueue.main.async {
                self.CharacterCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func getCharacters(){
        self.toggleLoading()
        var request = URLRequest(url: URL(string: "https://www.breakingbadapi.com/api/characters")!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            do{
                let characterResponse = try newJSONDecoder().decode(CharacterResponse.self, from: data!)
                for i in characterResponse{
                    let quotes = [String]()
                    let newChar = Character(id: i.charID, name: i.name, nickname: i.nickname, occupation: i.occupation?[0] ?? "unknown", portrayedBy: i.portrayed, birthdate: i.birthday, imageURL: i.img, quotes: quotes)
                    self.characterList.append(newChar)
                }
                self.toggleLoading()
                
            }catch{
                print(error.localizedDescription)
                self.toggleLoading()
            }
        }.resume()
    }
}
