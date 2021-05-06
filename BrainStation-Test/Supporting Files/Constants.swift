//
//  Constants.swift
//  BrainStation-Test
//
//  Created by Sudipto Roy on 5/6/21.
//  Copyright © 2021 Code_X Systems. All rights reserved.
//

import Foundation



// MARK: - Typealiases for closure
typealias CompletionWithMessage = (_ Success: Bool, _ withMessage: String) -> ()




// MARK: Base Url
/// Api base url
let BASE_URL    = "https://api.themoviedb.org/3/search/"

/// Api key
let API_KEY     = "38e61227f85671163c275f9bd95a8803"




// MARK: - Move DB apis
/// The MovieDB apis
struct MovieDBApis {
    static let getMovies = "\(BASE_URL)movie"
}
