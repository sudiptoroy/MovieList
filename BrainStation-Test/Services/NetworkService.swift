//
//  NetworkService.swift
//  BrainStation-Test
//
//  Created by Sudipto Roy on 5/6/21.
//  Copyright © 2021 Code_X Systems. All rights reserved.
//

import Foundation
import SwiftyJSON



final class NetworkService {
    
    
    /// NetworkService Singleton
    static let shared = NetworkService()
    
    
    /// Array of `Movie` object to store movie List from api
    var movieList = [Movie]()
    
    
    /// URLSession
    let urlSession = URLSession.shared
    
    
    
    
    
    // MARK: - Get Movies
    
    /// Get Movie list
    /// - Parameters:
    ///   - query: Search Query
    ///   - completion: success, message
    func getMovies (query: String = "marvel", completion: @escaping CompletionWithMessage) {
        
        print("\nGet Movies api - ",#function)
        
        
        var urlString = "\(MovieDBApis.getMovies)"
        
        let parameters: [String : String] = [
            "api_key"   : API_KEY,
            "query"     : query
        ]
        
        urlString += buildQueryString(fromDictionary: parameters)
        
        guard let url = URL(string: urlString) else {
            print("Failed to unwrap url")
            completion(false, "Error - Failed to unwrap url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("Response: \(response)")
            }
            if error == nil && data != nil {
                var json = JSON()
                guard let data = data else {
                    completion(false, "Failed to parse json")
                    return
                }
                
                do {
                    json = try JSON(data: data)
                    
                    let results = json["results"]
                    
                    self.movieList.removeAll()
                    if !results.isEmpty {
                        for i in 0..<results.count {
                            let genreIdsJson = results[i]["genre_ids"]
                            var genreIds = [String]()
                            for j in 0..<genreIdsJson.count {
                                genreIds.append("\(genreIdsJson[j])")
                            }
                            let movie = Movie.init(adult                : "\(results[i]["adult"])",
                                                   backdrop_path        : "\(results[i]["backdrop_path"])",
                                                   genre_ids            : genreIds,
                                                   id                   : "\(results[i]["id"])",
                                                   original_language    : "\(results[i]["original_language"])",
                                                   original_title       : "\(results[i]["original_title"])",
                                                   overview             : "\(results[i]["overview"])",
                                                   popularity           : "\(results[i]["popularity"])",
                                                   poster_path          : "\(results[i]["poster_path"])",
                                                   release_date         : "\(results[i]["release_date"])",
                                                   title                : "\(results[i]["title"])",
                                                   video                : "\(results[i]["video"])",
                                                   vote_average         : "\(results[i]["vote_average"])",
                                                   vote_count           : "\(results[i]["vote_count"])")
                            genreIds.removeAll()
                            self.movieList.append(movie)
                        }
                        completion(true, "succsss")
                    } else {
                        print("No data found")
                        completion(false, "Error: No data found")
                    }
                } catch {
                    print("Failed to parse json")
                    completion(false, "Error: Failed to parse json")
                }
                
            } else {
                print("Error - \(error!)")
                completion(false, "Error \(error!)")
            }
        }.resume()
    }
    
    
    
    
    /// Build query string
    private func buildQueryString(fromDictionary parameters: [String:String]) -> String {
        var urlVars:[String] = []
        
        for (k, value) in parameters {
            let value = value as NSString
            if let encodedValue = value.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                urlVars.append(k + "=" + encodedValue)
            }
        }

        return urlVars.isEmpty ? "" : "?" + urlVars.joined(separator: "&")
    }
}
