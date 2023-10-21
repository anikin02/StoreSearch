//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by anikin02 on 21.10.2023.
//

import UIKit

class SearchResultCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var nameArtistLabel: UILabel!
  @IBOutlet weak var artworkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
