//
//  SearchViewController.swift
//  StoreSearch
//
//  Created by anikin02 on 09.10.2023.
//

import UIKit

class SearchViewController: UIViewController {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - Search Bar Delegate extension

extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print("The search text is: '\(searchBar.text!)'") }
}

// MARK: - Table View Delegate extension

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}


