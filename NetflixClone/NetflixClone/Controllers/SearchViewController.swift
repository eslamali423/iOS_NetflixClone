//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK:- Vars
    
    private var tableView : UITableView = {
        let table =  UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()
    
    var viewModel = SearchViewModel()
    
    private let searchController : UISearchController = {
       let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Movie or a Tv Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        

        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.tintColor = .systemPink 
        navigationItem.searchController = searchController
        
        fetchData()
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
//MARK:- Get Discoverd Movies Data
    func fetchData(){
        viewModel.getDiscoverdMovies { (isSuccess) in
            if isSuccess{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
 

}


extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.discoverdMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else  {
            print("dont get the cell")
            return UITableViewCell()
        }
        let data = viewModel.discoverdMovies[indexPath.row]
        cell.configure(model: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        
    }
  
}

extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController
              else {
            return
        }
        
        viewModel.search(query: query) { (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    resultController.movies = self.viewModel.searchedMovies
                    resultController.collectionView.reloadData()
                }
            }
        }
    }
    
    
}



