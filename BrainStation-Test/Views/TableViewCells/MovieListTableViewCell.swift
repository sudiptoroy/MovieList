//
//  MovieListTableViewCell.swift
//  BrainStation-Test
//
//  Created by Sudipto Roy on 5/6/21.
//  Copyright © 2021 Code_X Systems. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    static let identifier = "movieListTableViewCell"
    
    
    // MARK: Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var movieImageView: LoadImageView!
    
    
    /// Update MovieListTableViewCell
    func updateView (movie: Movie) {
        movieImageView.downloaded(from: "\(IMAGE_BASE_URL)\(movie.poster_path)")
        movieDescriptionTextView.text = movie.overview
        movieTitleLabel.text = movie.title
    }
}
