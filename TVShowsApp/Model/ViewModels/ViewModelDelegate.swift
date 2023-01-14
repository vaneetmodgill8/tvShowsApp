//
//  ViewModelDelegate.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func update<ResultType>(withResult: ResultType)
    func handleError(error: LocalizedError?)
}
