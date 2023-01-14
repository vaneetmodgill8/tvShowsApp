//
//  ShowsListViewModel.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation


class ShowsListViewModel {
    
    var showsArray = [Shows]()
    var pageNo = 0
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
        if pageNo == 0 {
            self.showsArray.removeAll()
        }
        let (shows, error) = await GetShowsAPIClient.getShows(pageNo: pageNo)
        guard let newShows = shows else {
            self.delegate?.handleError(error: error)
            return
        }
        if !newShows.isEmpty {
            self.showsArray.append(contentsOf: newShows)
        }
        self.delegate?.update(withResult: self.showsArray)
    }
    
    private func searchTVShows(name: String? = nil) async {
        if name != self.searchKeyword {
            pageNo = 0
            self.showsArray.removeAll()
        }
        if pageNo == 0 {
            self.showsArray.removeAll()
        }
        self.searchKeyword = name ?? ""
        let (shows, error) = await GetShowsAPIClient.getSearchedShows(name: self.searchKeyword)
        guard let newShows = shows else {
            self.delegate?.handleError(error: error)
            return
        }
        if !newShows.isEmpty {
            let seriesFromResults = GetSearchedShowsResponseContent.arrayOfSeries(responses: newShows)
            self.showsArray.append(contentsOf: seriesFromResults)
        }
        self.delegate?.update(withResult: self.showsArray)
    }
}
