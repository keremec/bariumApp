//
//  EpisodesEntity.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 26.11.2022.
//

import Foundation

// MARK: - EpisodesResponseElement
struct CharacterResponseElement: Codable {
    let charID: Int?
    let name: String?
    let birthday: String?
    let occupation: [String]?
    let img: String?
    let status: Status?
    let nickname: String?
    let appearance: [Int]?
    let portrayed: String?
    let category: String?
    let betterCallSaulAppearance: [Int]?

    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
}

enum Status: String, Codable {
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}

typealias CharacterResponse = [CharacterResponseElement]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

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

    func episodesResponseTask(with url: URL, completionHandler: @escaping (CharacterResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
