//
//  GameOfThronesTableViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Jason Gresh on 10/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GameOfThronesTableViewController: UITableViewController {
  
  var episodes = [GOTEpisode]()
  var numOfSeason = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  func loadData() {
    guard let path = Bundle.main.path(forResource: "got", ofType: "json"),
      let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options:  NSData.ReadingOptions.mappedIfSafe),
      let dict = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSDictionary else {
        return
    }
    
    if let episodes = dict?.value(forKeyPath: "_embedded.episodes") as? [[String:Any]] {
      for epDict in episodes {
        if let ep = GOTEpisode(withDict: epDict) {
          self.episodes.append(ep)
        }
      }
    }
    
    for season in episodes {
      if season.season > numOfSeason {
        numOfSeason = season.season
      }
    }
  }
  
  // MARK: - Table view data source
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return numOfSeason
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Season \(section + 1)"
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard section + 1 <= numOfSeason else { return 0 }
    let numPerSect = episodes.filter({ $0.season == section + 1 })
    return numPerSect.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
    
    let seasonEP = episodes.filter({ ($0.season - 1) == indexPath.section })
    
    if let episodeCell = cell as? EpisodeTableViewCell {
      let episode = seasonEP[indexPath.row]
      episodeCell.episodeTitle.text = episode.name
      episodeCell.airDate.text = episode.airdate
    }
    
    return cell
  }
  
  
  // MARK: - Navigation
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let tappedEpisodeCell: UITableViewCell = sender as? UITableViewCell{
      if segue.identifier == "episodeDetailSegue"{
        let episodeDetails: EpisodeDetailViewController = segue.destination as! EpisodeDetailViewController
        let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedEpisodeCell)!
        
        let episode: GOTEpisode = episodes.filter { (episode) -> Bool in
          return (episode.season - 1 ) == cellIndexPath.section }[cellIndexPath.row]
        
        episodeDetails.thisEpisode = episode
      }
    }
  }
  
}
