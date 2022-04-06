//
//  HeroHeaderUIView.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit
import SDWebImage

class HeroHeaderUIView: UIView {

    //MARK:- Vars
    
    private let heroImageView : UIImageView = {
       let imageview = UIImageView()
        imageview.contentMode =  .scaleToFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    private let titleLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
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
    
        
        return label
    }()

    
    private let playButton : UIButton = {
       let button =  UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.layer.cornerRadius = 5
        return button
    }()
     
    private let downloadButton : UIButton = {
       let button =  UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(titleLabel)
        addSubview(rateLabel)
        addSubview(starImage)

        applyConstrains()
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK:- Gredient Function
    func addGradient(){
      let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    //MARK:- Constrains
    func applyConstrains() {
      
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
            titleLabel.widthAnchor.constraint(equalToConstant: bounds.width - 30 ),
            
            
            rateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            rateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            starImage.centerYAnchor.constraint(equalTo: rateLabel.centerYAnchor),
            starImage.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor,constant: 4),
            
//            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50),
//            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
//            playButton.widthAnchor.constraint(equalToConstant: 120),
//
//
//            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -50),
//            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
//            downloadButton.widthAnchor.constraint(equalToConstant: 120)
            
            
        ])
    }
    
    //MARK:- Configure Random Movie
    func configure(movie : Movie) {
        DispatchQueue.main.async { [weak self] in
            let path = movie.poster_path ?? ""
            guard let url = URL(string : "https://image.tmdb.org/t/p/w500/\(path)") else {
                print("CAANTTT GEET THE POSTER URLL")
                return}
            
            self?.heroImageView.sd_setImage(with: url, completed: nil)
            let title = movie.original_name ?? movie.original_title ?? "Unkonwn"
            print(title)
            self?.titleLabel.text = title
            self?.rateLabel.text = "\(movie.vote_average)"
        }
      
    }
    
}
