//
//
//  ShowDetailTableViewCell.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//

import UIKit


class ShowDetailTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var scheduleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    
    
    func setupDetail(data: Shows?) {
        guard let data = data else {
           return
        }
        self.titleLabel.text = data.name
        self.posterImageView.getImage(url: data.image?.original ?? "", placeholderImage: UIImage(named: Constants.ImagesName.placeholderImage))
        self.scheduleLabel.isHidden = false
        self.genresLabel.isHidden = false
        if let schedule = data.schedule, !schedule.time.isEmpty, !schedule.days.isEmpty {
            let time = schedule.time
            let days = schedule.days.joined(separator: ", ")
            self.scheduleLabel.text = "\(days) \(time)"
        } else {
            self.scheduleLabel.isHidden = true
        }
        if let genres = data.genres, !genres.isEmpty {
            self.genresLabel.text = "Genres: \(genres.joined(separator: ", "))"
        } else {
            self.genresLabel.isHidden = true
        }
        if let summary = data.summary, !summary.isEmpty {
            self.summaryLabel.text = summary.html2String.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
}
