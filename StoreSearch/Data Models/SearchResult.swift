//
//  SearchResult.swift
//  StoreSearch
//
//  Created by anikin02 on 14.10.2023.
//

class SearchResult: Codable, CustomStringConvertible {
  var trackName: String?
  var artistName: String?
 
  var name: String {
    return trackName ?? ""
  }
  
  var description: String {
    return String("\nResult - Name: \(name), Artist Name: \(artistName ?? "None")")
  }
}

class ResultsArray: Codable {
  var resultCount = 0
  var results = [SearchResult]()
}
