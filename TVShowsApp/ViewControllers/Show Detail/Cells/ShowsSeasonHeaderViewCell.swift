//
//  ShowsSeasonHeaderViewCell.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//

import UIKit

class ShowsSeasonHeaderViewCell: UITableViewHeaderFooterView {
    @IBOutlet private weak var headerTitle:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateHeader(seasonNo: Int) {
        self.headerTitle?.text = "Season \(seasonNo)"
    }
}
