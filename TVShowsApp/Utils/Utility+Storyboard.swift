//
//  Utility+Storyboard.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//


import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
}

fileprivate extension UIStoryboard {

    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}


extension UIStoryboard {
    static func loadShowDetalVC() -> ShowDetailViewController {
        return loadFromMain(ShowDetailViewController.className) as! ShowDetailViewController
    }
    static func loadEpisodeDetailViewController() -> EpisodeDetailViewController {
        return loadFromMain(EpisodeDetailViewController.className) as! EpisodeDetailViewController
    }
    
    
}
