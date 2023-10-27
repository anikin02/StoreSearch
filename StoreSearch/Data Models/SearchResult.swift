//
//  SearchResult.swift
//  StoreSearch
//
//  Created by anikin02 on 14.10.2023.
//

class SearchResult: Codable, CustomStringConvertible {
  var trackName: String?
  var artistName: String?
  var kind: String?
  var trackPrice: Double?
  var currency: String
  var imageSmall: String
  var imageLarge: String
  var storeURL: String?
  var genre: String
  
  enum CodingKeys: String, CodingKey {
    case imageSmall = "artworkUrl60"
    case imageLarge = "artworkUrl100"
    case storeURL = "trackViewUrl"
    case genre = "primaryGenreName"
    case kind, artistName, trackName
    case trackPrice, currency
  }
 
  var name: String {
    return trackName ?? ""
  }
  
  var description: String {
    return String("\nResult - Name: \(name), Artist Name: \(artistName ?? "None"), Genre: \(genre), Prie: \(trackPrice)")
  }
}

class ResultsArray: Codable {
  var resultCount = 0
  var results = [SearchResult]()
}
