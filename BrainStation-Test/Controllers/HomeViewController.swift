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
    
    

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetup()
    }
    
    
    
    // MARK: - TableViewSetup
    private func tableViewSetup () {
        //self.mainContentView.isHidden = true
        self.movieListTableView.delegate        = self
        self.movieListTableView.dataSource      = self
        self.movieListTableView.rowHeight       = 150
    }
}




// MARK: - TableView datasource and Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    // MARK: Cell for row at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.movieListTableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell {
            return cell
        } else {
            return MovieListTableViewCell()
        }
    }
}
