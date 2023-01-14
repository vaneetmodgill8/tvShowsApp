//
//  ShowsListViewController.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import UIKit

class ShowsListViewController: UIViewController {

    //MARK: IBOutlet(s)
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var showsCollectionView: UICollectionView!
    
    //MARK: Variable(s)
    private var viewModel: ShowsListViewModel = ShowsListViewModel()

    
    //MARK: LifeCycle Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.registerNibs()
        self.showLoading()
        self.viewModel.getTVShows()
    }
    
    //MARK: Method(s)
    private func setupUI() {
        self.viewModel.delegate = self
    }

    private func registerNibs(){
        self.showsCollectionView.register(UINib(nibName: ShowsCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ShowsCollectionViewCell.className)
    }
}

//MARK: CollectionView Delegate and DataSourse
extension ShowsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.showsArray.count - 1 {
            self.viewModel.pageNo += 1
            self.viewModel.getTVShows()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.showsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowsCollectionViewCell.className, for: indexPath) as? ShowsCollectionViewCell
        cell?.setupData(data: self.viewModel.showsArray[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard.loadShowDetalVC()
        detailVC.selectedShow = self.viewModel.showsArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 20) / 3.0
        return CGSize(width: width, height: width * (collectionView.frame.size.height / collectionView.frame.size.width))
    }
    

}


//MARK: Search Delegates
extension ShowsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.showLoading()
        if searchBar.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.viewModel.pageNo = 0
        }
        self.viewModel.getTVShows(searchKeyword: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.showLoading()
        if searchBar.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.viewModel.pageNo = 0
        }
        self.viewModel.getTVShows()
    }
 }

//MARK: ViewModel Delegate
extension ShowsListViewController: ViewModelDelegate {
    
    func update<ResultType>(withResult: ResultType) {
        DispatchQueue.main.async { [weak self] in
            self?.dismissLoading()
            self?.searchBar.resignFirstResponder()
            self?.showsCollectionView.reloadData()
        }
    }
    
    func handleError(error: LocalizedError?) {
        DispatchQueue.main.async { [weak self] in
            self?.dismissLoading()
            self?.showsCollectionView.reloadData()
            self?.showAlertForErrors(message: error?.localizedDescription ?? RequestError.unknown.localizedDescription)
        }
    }
}
