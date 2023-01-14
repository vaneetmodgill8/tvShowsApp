//
//  ShowDetailViewModel.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//

import Foundation


class ShowDetailViewModel {
    
    weak var delegate: ViewModelDelegate?
    var episodesBySeason: [Int : [Episode]] = [:]
    
    func loadEpisodes(show: Shows?) async {
        guard let show = show else {
            return
        }
        let showID = show.id
        let (episodes, error) = await GetShowDetailClient.getEpisodes(showID: showID)
        if let episodes = episodes {
            self.splitEpisodesBySeason(episodes: episodes.embedded.episodes)
            self.delegate?.update(withResult: self.episodesBySeason)
        } else {
            self.delegate?.handleError(error: error)
        }
    }
    
    private func splitEpisodesBySeason(episodes: [Episode]) {
        for episode in episodes {
            if self.episodesBySeason[episode.season] == nil {
                self.episodesBySeason[episode.season] = []
            }
            self.episodesBySeason[episode.season]?.append(contentsOf: CollectionOfOne(episode))
        }
    }
}
