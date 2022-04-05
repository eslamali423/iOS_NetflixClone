//
//  MovieCollectionViewCell.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
   
    
    //MARK:- Vars
    static let identifier = "MovieCollectionViewCell"
    
    private let posterImageView : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView.frame = contentView.bounds
    }
    
    
    public func configure (with model : String) {
        guard let url = URL(string : "https://image.tmdb.org/t/p/w500/\(model)") else {return}
        
        self.posterImageView.sd_setImage(with: url, completed: nil)
        
        
        
    }
    
    
    
    
}
