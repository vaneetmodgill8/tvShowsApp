//
//  ShowsListViewModel.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation


class ShowsListViewModel {
    
    var showsArray = [Shows]()
    var hasMoreShows: Bool = true
    weak var delegate: ViewModelDelegate?
    private var searchKeyword: String = ""
    
    
    func getTVShows(searchKeyword: String? = nil) {
        Task(priority: .background) {
            if (searchKeyword != nil) && searchKeyword != ""{
                await self.searchTVShows(name: searchKeyword)
            } else {
                await self.getTVShows()
            }
        }
    }

    
    private func getTVShows() async {
        self.showsArray.removeAll()
        let (shows, error) = await GetShowsAPIClient.getShows()
        self.hasMoreShows = false
        guard let newShows = shows else {
            self.delegate?.handleError(error: error)
            return
        }
        if !newShows.isEmpty {
            self.showsArray.append(contentsOf: newShows)
            self.hasMoreShows = true
        }
        self.delegate?.update(withResult: self.showsArray)
    }
    
    private func searchTVShows(name: String? = nil) async {
        if name != self.searchKeyword {
            self.showsArray.removeAll()
        }
        self.searchKeyword = name ?? ""
        let (shows, error) = await GetShowsAPIClient.getSearchedShows(name: self.searchKeyword)
        self.hasMoreShows = false
        guard let newShows = shows else {
            self.delegate?.handleError(error: error)
            return
        }
        if !newShows.isEmpty {
            let seriesFromResults = GetSearchedShowsResponseContent.arrayOfSeries(responses: newShows)
            self.showsArray.append(contentsOf: seriesFromResults)
            self.hasMoreShows = true
        }
        self.delegate?.update(withResult: self.showsArray)
    }
}
