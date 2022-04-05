//
//  HeroHeaderUIView.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit

class HeroHeaderUIView: UIView {

    //MARK:- Vars
    
    private let heroImageView : UIImageView = {
       let imageview = UIImageView()
        imageview.contentMode =  .scaleToFill
        imageview.clipsToBounds = true
        imageview.image = UIImage(named: "movieImage")
        return imageview
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
        addSubview(playButton)
        addSubview(downloadButton)
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
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            
            
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -50),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
            
            
        ])
        
       
    }
    
}
