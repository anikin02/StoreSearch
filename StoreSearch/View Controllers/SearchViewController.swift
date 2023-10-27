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
    
    var cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
    
    cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
    tableView.register( cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
    
    searchBar.becomeFirstResponder()
  }
  
  // MARK: - Helper Methods
  
  func iTunesURL(searchText: String) -> URL {
    let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    let urlString = String(
      format: "https://itunes.apple.com/search?term=%@", 
      encodedText)
    
    return URL(string: urlString)!
  }
  
  func performStoreRequest(with url: URL) -> Data? {
    do {
      return try Data(contentsOf: url)
    } catch {
      print("Download Error: \(error.localizedDescription)")
    }
    return nil
  }
  
  func parse(data: Data) -> [SearchResult] {
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(ResultsArray.self, from: data)
      return result.results
    } catch {
      print("JSON Error: \(error)")
      return []
    }
  }
}

// MARK: - Search Bar Delegate extension

extension SearchViewController: UISearchBarDelegate {
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if !searchBar.text!.isEmpty {
      searchBar.resignFirstResponder()
      
      hasSearched = true
      searchResults = []
      
      let url = iTunesURL(searchText: searchBar.text!)
      
      if let data = performStoreRequest(with: url) {
        let results = parse(data: data)
        print("Got results: \(results)")
      }
      
      tableView.reloadData()
    }
  }
}

// MARK: - Table View Delegate extension

struct TableView {
  struct CellIdentifiers {
    static let searchResultCell = "SearchResultCell"
    static let nothingFoundCell = "NothingFoundCell"
  }
}

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
    if searchResults.isEmpty {
      return tableView.dequeueReusableCell(
        withIdentifier: TableView.CellIdentifiers.nothingFoundCell,
        for: indexPath)
    } else {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: TableView.CellIdentifiers.searchResultCell,
        for: indexPath) as! SearchResultCell
      
      let searchResult = searchResults[indexPath.row]
      
      cell.nameLabel.text = searchResult.name
      cell.nameArtistLabel.text = searchResult.artistName
      
      return cell
    }
  }
}


