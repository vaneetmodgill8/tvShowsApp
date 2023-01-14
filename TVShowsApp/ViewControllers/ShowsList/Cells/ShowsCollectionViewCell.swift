//
//  ShowsCollectionViewCell.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import UIKit

class ShowsCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlet(s)
    @IBOutlet private weak var showNameLabel: UILabel!
    @IBOutlet private weak var bannerImageView: UIImageView!
    
    //MARK: Method(s)
    func setupData(data: Shows) {
        self.showNameLabel.text = data.name
        self.bannerImageView.getImage(url: data.image?.medium ?? "", placeholderImage: UIImage(named: Constants.ImagesName.placeholderImage))
    }
}
