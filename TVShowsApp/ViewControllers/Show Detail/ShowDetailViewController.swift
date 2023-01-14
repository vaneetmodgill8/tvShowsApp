//
//  ShowDetailViewController.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//

import UIKit

class ShowDetailViewController: UIViewController {
    
    @IBOutlet private weak var showDetailTableView: UITableView!
    
    var selectedShow: Shows?
    private var viewModel: ShowDetailViewModel = ShowDetailViewModel()
    private var selectedEpisode: Episode?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.registerNibs()
        self.getEpisodes()
    }
    
    private func registerNibs() {
        if #available(iOS 15.0, *) {
            showDetailTableView.sectionHeaderTopPadding = 0
        }
        self.showDetailTableView.register(UINib(nibName: ShowsSeasonHeaderViewCell.className, bundle: nil), forHeaderFooterViewReuseIdentifier: ShowsSeasonHeaderViewCell.className)
        self.showDetailTableView.register(UINib(nibName: ShowsEpisodesTableViewCell.className, bundle: nil), forCellReuseIdentifier: ShowsEpisodesTableViewCell.className)
        self.showDetailTableView.register(UINib(nibName: ShowDetailTableViewCell.className, bundle: nil), forCellReuseIdentifier: ShowDetailTableViewCell.className)
    }
    
    private func getEpisodes() {
        self.showLoading()
        Task(priority: .background) {
            await self.viewModel.loadEpisodes(show: self.selectedShow)
        }
    }
}


// ViewModel
extension ShowDetailViewController: ViewModelDelegate {
    
    func update<ResultType>(withResult: ResultType) {
        DispatchQueue.main.async { [weak self] in
            self?.dismissLoading()
            self?.showDetailTableView.reloadData()
        }
    }
    
    func handleError(error: LocalizedError?) {
        DispatchQueue.main.async { [weak self] in
            self?.dismissLoading()
            self?.showAlertForErrors(message: error?.localizedDescription ?? RequestError.unknown.localizedDescription)
        }
    }
}


extension ShowDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.episodesBySeason.count + 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let showsSeasonHeaderViewCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ShowsSeasonHeaderViewCell.className) as? ShowsSeasonHeaderViewCell
        showsSeasonHeaderViewCell?.updateHeader(seasonNo: section)
        return showsSeasonHeaderViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNonzeroMagnitude
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.viewModel.episodesBySeason[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let showDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: ShowDetailTableViewCell.className, for: indexPath) as! ShowDetailTableViewCell
            showDetailTableViewCell.setupDetail(data: self.selectedShow)
            return showDetailTableViewCell
        }
        let showsEpisodesTableViewCell = tableView.dequeueReusableCell(withIdentifier: ShowsEpisodesTableViewCell.className, for: indexPath) as! ShowsEpisodesTableViewCell
        showsEpisodesTableViewCell.updateData(episode: self.viewModel.episodesBySeason[indexPath.section]?[indexPath.row])
        return showsEpisodesTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        let episodeDetailViewController = UIStoryboard.loadEpisodeDetailViewController()
        episodeDetailViewController.selectedEpisode = self.viewModel.episodesBySeason[indexPath.section]?[indexPath.row]
        self.navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}
