//
//  DownloadsViewController.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit

class DownloadsViewController: UIViewController {

    
    //MARK:- Vars
    
    private var tableView : UITableView = {
        let table =  UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()
    
    var viewModel = CoreDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
   
    
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    
        fetchMovies()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { (_) in
            self.fetchMovies()
        }
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    //MARK:- Fetch Movies
    
    func fetchMovies () {
        viewModel.fetchMovies { (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DownloadsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else  {
            return UITableViewCell()
        }
        
        cell.configure(model: viewModel.movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        switch editingStyle {
        case .delete :
            viewModel.deleteMovie(model: viewModel.movies[indexPath.row]) { (isSuccess) in
                if isSuccess {
                    tableView.reloadData()
                }
            }
            viewModel.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
    
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.movies[indexPath.row]
        DispatchQueue.main.async { [weak self]  in
            let movieVC = MoviePreviewViewController()
            movieVC.configure(model: movie)
            
            movieVC.downloadButton.isHidden = true
            self?.navigationController?.pushViewController(movieVC, animated: true)
        }
       
        
    }
    
}
