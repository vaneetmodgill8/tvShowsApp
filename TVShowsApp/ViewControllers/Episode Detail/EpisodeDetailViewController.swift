//
//  ShowsListViewController.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var seasonLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    
    var selectedEpisode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        guard let episode = selectedEpisode else {
            return
        }
        self.nameLabel.text = episode.name
        self.posterImageView.getImage(url: episode.image?.original ?? "", placeholderImage: UIImage(named: Constants.ImagesName.placeholderImage))
        self.seasonLabel.text = "S\(episode.season) E\(episode.number)"
        if let summary = episode.summary, !summary.isEmpty {
            self.summaryLabel.text = summary.html2String.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
}
