//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppSearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private let searchService = ITunesSearchService()
    var searchResults = [ITunesApp]() {
        didSet {
            self.searchView.tableView.isHidden = false
            self.searchView.tableView.reloadData()
            self.searchView.searchBar.resignFirstResponder()
        }
    }
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    private let presenter: AppSearchViewOutput
    
    
    init(presenter: AppSearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }
}

//MARK: - UITableViewDataSource
extension AppSearchViewController: UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? AppCell else {
            return dequeuedCell
        }
        let app = self.searchResults[indexPath.row]
        let cellModel = AppCellModelFactory.cellModel(from: app)
        cell.configure(with: cellModel)
        return cell
    }
 }

//MARK: - UITableViewDelegate
extension AppSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let app = searchResults[indexPath.row]
        self.presenter.viewDidSelectApp(app)
    }
}

//MARK: - UISearchBarDelegate
extension AppSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        self.presenter.viewDidSearch(with: query)
    }
}

// MARK: - Input
 extension AppSearchViewController: AppSearchViewInput {

     func showError(error: Error) {
         let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
         let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alert.addAction(actionOk)
         self.present(alert, animated: true, completion: nil)
     }

     func showNoResults() {
         self.searchResults = []
         self.searchView.tableView.reloadData()
     }

     func hideNoResults() {
         self.searchView.emptyResultView.isHidden = true
     }

     func throbber(show: Bool) {
         UIApplication.shared.isNetworkActivityIndicatorVisible = show
     }
 }