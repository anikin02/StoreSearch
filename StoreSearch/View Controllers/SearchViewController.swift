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
  
  var hasSearched = false
  var searchResults = [SearchResult]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInset = UIEdgeInsets(top: 51, left: 0, bottom: 0, right: 0)
    
    let cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
  }
}

// MARK: - Search Bar Delegate extension

extension SearchViewController: UISearchBarDelegate {
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    hasSearched = true
    for i in 0...2 {
      let result = SearchResult(name: String(format: "Fake Result %d for", i), nameArtist: searchBar.text!)
      searchResults.append(result)
    }
    tableView.reloadData()
    searchBar.resignFirstResponder()
  }
}

// MARK: - Table View Delegate extension

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if !hasSearched {
      return 0
    } else if searchResults.isEmpty {
      return 1
    } else {
      return searchResults.count
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if searchResults.isEmpty {
      return nil
    } else {
      return indexPath
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "SearchResultCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchResultCell
    
    if searchResults.isEmpty {
      cell.nameLabel.text = "Nothing found"
      cell.nameArtistLabel.text = ""
    } else {
      let searchResult = searchResults[indexPath.row]
      
      cell.nameLabel.text = searchResult.name
      cell.nameArtistLabel.text = searchResult.nameArtist
    }
    
    return cell
  }
}


