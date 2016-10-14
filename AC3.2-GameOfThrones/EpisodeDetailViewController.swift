//
//  EpisodeDetailViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Eric Chang on 10/12/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

  @IBOutlet weak var episodeImageView: UIImageView!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeSeason: UILabel!
  @IBOutlet weak var episodeAirDate: UILabel!
  @IBOutlet weak var episodeSummary: UITextView!
  
  var thisEpisode: GOTEpisode?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      setupData()
        // Do any additional setup after loading the view.
    }

  func setupData() {
    guard let got = thisEpisode else { return }
    episodeTitle.text = got.name
    episodeSeason.text = "Season \(got.season), episode \(got.number)"
    episodeAirDate.text = got.airdate

    let newSum = got.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    episodeSummary.text = newSum
    
    let url = URL(string: got.image)
    guard let data = try? Data(contentsOf: url!) else { return }
    episodeImageView.image = UIImage(data: data)
  }
}
