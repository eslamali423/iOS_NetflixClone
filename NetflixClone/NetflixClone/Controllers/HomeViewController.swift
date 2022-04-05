//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- Vars
    
    let sectionTitles : [String] = ["Trending Movies", "Trending TV", "Popular"  , "Upcomming Movies", "Top Rated"]
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    var viewModel = MovieViewModel()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // set the header of the table view
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2))
        tableView.tableHeaderView = headerView
        
        configureNavBar()
        
        
        APICaller.shared.getYoutubeMovie(query: "harry") { (result) in
                
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    
    //MARK:- Configure Navigation Controller Function
    func configureNavBar()  {
        
        let containerView = UIControl(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        //  containerView.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        let image = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        image.image = UIImage(named: "netflixLogo")
        containerView.addSubview(image)
        let netflixLogo = UIBarButtonItem(customView: containerView)
        netflixLogo.width = 20
        navigationItem.leftBarButtonItem = netflixLogo
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        
        navigationController?.navigationBar.tintColor = .systemPink 
    }
    
    
    
}

//MARK:- HomeViewController Extension for TableView
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        
                switch indexPath.section {
                case Sections.TrendingMovies.rawValue:
                    viewModel.getTrendingMovie { (movies) in
                        cell.configure(with: movies)
                    }
                    
                case Sections.TrendingTv.rawValue:
                    viewModel.getTrendingTv { (movies) in
                        cell.configure(with: movies)
                    }
                    
                case Sections.Popular.rawValue:
                    viewModel.getpopularMovie { (movies) in
                        cell.configure(with: movies)
                    }
                case Sections.Upcomming.rawValue:
                    viewModel.getUpcommingMovie { (movies) in
                        cell.configure(with: movies)
                    }
                case Sections.TopRated.rawValue:
                    viewModel.getTopRatedgMovie { (movies) in
                        cell.configure(with: movies)
                    }
        
                default:
                    return UITableViewCell()
                }
        
        return cell
    }
    // set the height for every cell 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // set the height for section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //set the title for sectioins
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // this function to setup style for section textlabel
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else  {return}
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .label
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
    
    // this function to hide navigationBar when scrolling down
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let defualtOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defualtOffset
        
        navigationController?.navigationBar.transform = .init(translationX : 0 ,y : min(0, -offset))
        
    }
    
    
}

enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcomming = 3
    case TopRated = 4
    
    
}
