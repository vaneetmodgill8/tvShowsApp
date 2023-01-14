//
//  ShowsEpisodesTableViewCell.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//


import UIKit

class ShowsEpisodesTableViewCell: UITableViewCell {
    @IBOutlet weak var EpisodeNameLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateData(episode: Episode?) {
        guard let episode = episode else {
            return
        }
        self.episodeImageView.getImage(url: episode.image?.medium ?? "", placeholderImage: UIImage(named: Constants.ImagesName.placeholderImage))
        self.EpisodeNameLabel?.text = "\(episode.name)"
    }
}
