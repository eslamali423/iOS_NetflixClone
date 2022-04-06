//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import UIKit
import CoreData

protocol CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCell(cell : CollectionViewTableViewCell, model : Movie)
}


class CollectionViewTableViewCell: UITableViewCell {
    
    //MARK:- Vars
    
    static let identifier = "CollectionViewTableViewCell"
    
     var delegate : CollectionViewTableViewCellDelegate?
    
    private var movies : [Movie] = []

    var coreDataViewModel = CoreDataViewModel()
  
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    //MARK:- Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    //MARK:- Cofigure teh cell in collectionView
    public func configure (with movies : [Movie]){
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    //MARK:- Download Movie
    func downloadMovie(indexPath : IndexPath) {
        let movie = movies[indexPath.row]
       
        coreDataViewModel.downloadMovie(movie: movie) { (isSuccess) in
            NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
        }
        
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        guard let modelPath = movies[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: modelPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    // Did tap On Item

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        
        self.delegate?.collectionViewTableViewCell(cell: self, model: movie)

    }
    // This Function Called if w Long Press on item
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration (identifier: nil, previewProvider: nil) { _ in
            let downloadAction = UIAction(title: "Download", image: UIImage(systemName: "arrow.down.to.line"), identifier: nil, discoverabilityTitle: nil, state: .off) { [weak self] _ in
                self?.downloadMovie(indexPath: indexPath)
            }
            let saveAction = UIAction(title: "Save", image: UIImage(systemName: "bell"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                print("save tapped")
            }
            
            let addListAction = UIAction(title: "Add to My List", image: UIImage(systemName: "plus"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                print("add to list tapped")
            }
            
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [addListAction,saveAction,downloadAction])
        }
  
    return config
    }
    
    
    
}
