//
//  EpisodeTableViewCell.swift
//  AC3.2-GameOfThrones
//
//  Created by Eric Chang on 10/12/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var airDate: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
