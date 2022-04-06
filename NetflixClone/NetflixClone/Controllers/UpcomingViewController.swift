//
//  UpcomingViewController.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    //MARK:- Vars
    
    private var tableView : UITableView = {
        let table =  UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()
    
    var viewModel = UpcommingMoviesViewModel()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Upcomming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds 
    }
    
    //MARK:- Fetch Data
    func fetchData(){
        viewModel.getUpcommingMovies { (isSuccess) in
            if isSuccess{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    
    
}

extension UpcomingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcommingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else  {
            print("dont get the cell")
            return UITableViewCell()
        }
        let data = viewModel.upcommingMovies[indexPath.row]
        cell.configure(model: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.upcommingMovies[indexPath.row]
        DispatchQueue.main.async { [weak self]  in
            let movieVC = MoviePreviewViewController()
            movieVC.configure(model: movie)
            self?.navigationController?.pushViewController(movieVC, animated: true)
        }
       
        
        
    }
    
    
    
    
}


