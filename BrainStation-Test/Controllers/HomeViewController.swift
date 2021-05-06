//
//  HomeViewController.swift
//  BrainStation-Test
//
//  Created by Sudipto Roy on 5/6/21.
//  Copyright © 2021 Code_X Systems. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    /// Array of movie object to store movieList
    var movieList = [Movie]()
    
    
    /// NerworkService singleton
    let networkService = NetworkService.shared
    

    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetup()
        fetchMovieList(query: "marvel")
        self.setupUI()
    }
    
    
    
    private func setupUI () {
        self.activityIndicator.isHidden = true
    }
    
    
    
    // MARK: - TableViewSetup
    private func tableViewSetup () {
        //self.mainContentView.isHidden = true
        self.movieListTableView.delegate        = self
        self.movieListTableView.dataSource      = self
        self.movieListTableView.rowHeight       = UITableView.automaticDimension
        self.movieListTableView.estimatedRowHeight = 150
    }
    
    
    
    
    // MARK: - Fetch Movie list
    
    /// Fetch movie list
    /// - Parameter query: search query
    private func fetchMovieList (query: String) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        self.networkService.getMovies(query: query) { (success, message) in
            if success {
                self.movieList = self.networkService.movieList
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.view.isUserInteractionEnabled = true
                    self.movieListTableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.view.isUserInteractionEnabled = true
                    Alert.showAlert(self, title: "Failed to load data", message: "\(message)")
                }
            }
        }
    }
}




// MARK: - TableView datasource and Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movieList.isEmpty {
            return 0
        } else {
            return self.movieList.count
        }
    }
    
    
    
    // MARK: Cell for row at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.movieListTableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell {
            if !self.movieList.isEmpty {
                cell.updateView(movie: self.movieList[indexPath.row])
            }
            return cell
        } else {
            return MovieListTableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
