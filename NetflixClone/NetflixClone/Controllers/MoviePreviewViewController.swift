//
//  MoviePreviewViewController.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 06/04/2022.
//

import UIKit
import WebKit

class MoviePreviewViewController: UIViewController {
    
    //MARK:- Vars
    
    var youtubeViewModel = YoutubeResponseViewModel()
    var coreDataViewModel = CoreDataViewModel()
    var currentMovie : Movie?
   

    private let webView : WKWebView = {
        let wetView = WKWebView()
        wetView.translatesAutoresizingMaskIntoConstraints = false
        return wetView
    }()
    
    
    private let titleLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry Potter"
        return label
    }()
    
    private let starImage : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "star.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        
        button.tintColor = .systemYellow
        
        return button
    }()
    
    private let rateLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "5.7"
        
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "15/10/2020"
        
        return label
    }()
    
    private let overviewLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Harry Potter Harry Potter Harry Potter Harry Potter Harry Potter Harry Potter Harry Potter Harry Potter "
        
        return label
    }()
    
    public let downloadButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 18, weight : .bold)
        return button
    }()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(starImage)
        view.addSubview(rateLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        applyConstraints()
        
        downloadButton.addTarget(self, action: #selector(didTapDownloadButton), for: .touchUpInside)
        
    }
    
    @objc func didTapDownloadButton () {
        guard let movie = currentMovie  else {
            return
        }
        coreDataViewModel.downloadMovie(movie: movie) { (isSuccess) in
            NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
        }
        
    }
    
    
    
    //MARK:- Constraints
    func applyConstraints(){
        NSLayoutConstraint.activate([
            
            webView.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor,constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant:2),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            
            starImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            starImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            rateLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: starImage.leadingAnchor,constant: -4),
            
            overviewLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 5),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor,constant: 30),
            downloadButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    //MARK:- Configure With Model
    func configure (model :Movie) {
        self.currentMovie = model
        titleLabel.text = model.original_name ?? model.original_title ?? "Unkonwn"
        overviewLabel.text = model.overview
        rateLabel.text = "\(model.vote_average)"
        let date =  model.release_date ?? "Unknown"
        dateLabel.text = "Released in : \(date)"
        
        guard let movieName = model.original_name ?? model.original_title else {return}
        
        youtubeViewModel.getMovie(query: movieName + " trailer") { (videoElement) in
            print (videoElement.id)
            guard let url = URL(string: "https://www.youtube.com/embed/\(videoElement.id.videoId!)") else {
                print("cant get the video form urllllll")
                return}
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url))

            }
        }
  
    }
    //this function for Download View Controller
    func configure (model :MovieItem) {
       
        titleLabel.text = model.original_name ?? model.original_title ?? "Unkonwn"
        overviewLabel.text = model.overview
        rateLabel.text = "\(model.vote_average)"
        let date =  model.release_date ?? "Unknown"
        dateLabel.text = "Released in : \(date)"
        
        guard let movieName = model.original_name ?? model.original_title else {return}
        
        youtubeViewModel.getMovie(query: movieName + " trailer") { (videoElement) in
            print (videoElement.id)
            guard let url = URL(string: "https://www.youtube.com/embed/\(videoElement.id.videoId!)") else {
                print("cant get the video form urllllll")
                return}
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url))

            }
        }
  
    }
    
    
    
}
