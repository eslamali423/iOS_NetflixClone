//
//  MovieTableViewCell.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    //MARK:- Vars
   static let identifier = "MovieTableViewCell"
    
    private let moviePosterImage : UIImageView = {
       let image =  UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    
    private let titleLabel : UILabel = {
       let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    private let playButton : UIButton = {
    let button = UIButton()
        let image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .systemPink
        
    return button
    }()
    
    //MARK:- Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(moviePosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)

        applyConstraints()
        
    }
    

    required init?(coder: NSCoder) {
        fatalError()
    }
  
    
    
    //MARK:- Constrains
    func applyConstraints()  {
       
        NSLayoutConstraint.activate([
            moviePosterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviePosterImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            moviePosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:  -10),
            moviePosterImage.widthAnchor.constraint(equalToConstant: 100),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor,constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
           // titleLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor,constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
       
            
            

        ])
        
        
    }
    
    
    //MARK:- Configure Cell
    func configure (model : Movie) {
        guard let url = URL(string : "https://image.tmdb.org/t/p/w500/\(model.poster_path ?? "")") else {return}

        moviePosterImage.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.original_title ?? model.original_title ?? "Unknown"
    
    }
}
