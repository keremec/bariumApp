//
//  EpisodesSV.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 26.11.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let episodeResponse = try? newJSONDecoder().decode(EpisodeResponse.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.episodeResponseElementTask(with: url) { episodeResponseElement, response, error in
//     if let episodeResponseElement = episodeResponseElement {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - EpisodeResponseElement
struct EpisodeResponseElement: Codable {
    let episodeID: Int?
    let title, season, airDate: String?
    let characters: [String]?
    let episode: String?
    let series: Series?

    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case title, season
        case airDate = "air_date"
        case characters, episode, series
    }
}

enum Series: String, Codable {
    case betterCallSaul = "Better Call Saul"
    case breakingBad = "Breaking Bad"
}

typealias EpisodeResponse = [EpisodeResponseElement]



// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func episodeResponseTask(with url: URL, completionHandler: @escaping (EpisodeResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
