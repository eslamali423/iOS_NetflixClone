//
//  CoreDataViewModel.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 06/04/2022.
//

import Foundation
import CoreData

class CoreDataViewModel {
    
    var movies : [MovieItem] = []
    
    //MARK:- Download Movies To CoreData 
    func downloadMovie(movie : Movie, completion: @escaping (Bool)->Void)  {
        
        CoreDataManager.shared.downloadMovie(model: movie) { (result) in
            switch result {
            case .success():
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            
            }
        }
       
    }
     //MARK:- Fetch All Movies Items Form Core Data
    func fetchMovies(completion: @escaping (Bool)->Void){
        CoreDataManager.shared.fetchMoviesFormDatabase { (result) in
            switch result {
            case .success(let movies):
                self.movies = movies
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            
            }
        }
    }
    
    //MARK:- Delete Movie Form CoreData
    func deleteMovie(model: MovieItem,completion: @escaping (Bool)->Void)  {
        
        CoreDataManager.shared.deleteMovie(model: model) { (result) in
            switch result {
            case .success():
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
        }
    }
    
    
    
}

}
