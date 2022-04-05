//
//  SearchViewModel.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import Foundation

class SearchViewModel {
   
    var discoverdMovies : [Movie] = []
    var searchedMovies : [Movie] = []

    func getDiscoverdMovies(completion: @escaping (Bool)->Void)  {
        APICaller.shared.getDiscoverdMovies { (moviesResult) in
            
            switch moviesResult {
            case .success(let movies) :
                self.discoverdMovies = movies
                completion(true)

            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
    
    
    func search(query : String, complection: @escaping (Bool)->Void)  {
        APICaller.shared.searchMovies(query: query) { (moviesResult) in
            switch moviesResult {
            case .success(let movies) :
                self.searchedMovies = movies
                complection(true)
            case .failure(let error):
                print(error.localizedDescription)
                complection(false)
            }
        }
    }
}
