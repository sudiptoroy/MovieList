//
//  Movie.swift
//  BrainStation-Test
//
//  Created by Sudipto Roy on 5/6/21.
//  Copyright © 2021 Code_X Systems. All rights reserved.
//

import Foundation


/// Movie codable struct to map and store api response
struct Movie: Codable {
    let adult               : String
    let backdrop_path       : String
    let genre_ids           : [String]
    let id                  : String
    let original_language   : String
    let original_title      : String
    let overview            : String
    let popularity          : String
    let poster_path         : String
    let release_date        : String
    let title               : String
    let video               : String
    let vote_average        : String
    let vote_count          : String
}
