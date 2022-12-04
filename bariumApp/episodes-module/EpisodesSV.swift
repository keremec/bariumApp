//
//  EpisodesSV.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 26.11.2022.
//

import Foundation

extension EpisodesVC{
    
    func toggleLoading(){
        isLoading = !isLoading
        if(isLoading){
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
        }
        else{
            DispatchQueue.main.async {
                self.episodesTableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func getEpisodes(){
        self.toggleLoading()
        var request = URLRequest(url: URL(string: "https://www.breakingbadapi.com/api/episodes?series=Breaking+bad")!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            do{
                let episodeResponse = try newJSONDecoder().decode(EpisodeResponse.self, from: data!)
                for i in episodeResponse{
                    let seasonIndex = (Int(i.season?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "0") ?? 0) - 1
                    let episodeIndex = (Int(i.episode?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "0") ?? 0) - 1
                    if(seasonIndex < 0 || episodeIndex < 0){
                        //print("\(i.season)x\(i.episode)")
                        continue
                    }
                    let title = i.title ?? "unnamed"
                    while( seasonIndex + 1 > self.list.count ){
                        self.list.append([])
                    }
                    while( episodeIndex + 1 > self.list[seasonIndex].count ){
                        self.list[seasonIndex].append(Episode(id: nil, title: nil, characters: nil))
                    }
                    let ep = Episode(id: i.episodeID, title: title, characters: i.characters)
                    self.list[seasonIndex][episodeIndex] = ep
                    
                }
                self.toggleLoading()
                
            }catch{
                print(error.localizedDescription)
                self.toggleLoading()
            }
        }.resume()
    }
}
