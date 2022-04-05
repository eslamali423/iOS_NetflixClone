//
//  MovieViewModel.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import Foundation

class MovieViewModel {
    
    func getTrendingMovie(completion: @escaping ([Movie])->Void){
        APICaller.shared.getTrendingMovies { (MoviesResult) in
           
            switch MoviesResult {
            case .success(let movies) :
                completion(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTrendingTv(completion: @escaping ([Movie])->Void){
        APICaller.shared.getTrendingTv { (MoviesResult) in
           
            switch MoviesResult {
            case .success(let movies) :
                completion(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getpopularMovie(completion: @escaping ([Movie])->Void){
        APICaller.shared.getPopularMovies { (MoviesResult) in
           
            switch MoviesResult {
            case .success(let movies) :
                completion(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getUpcommingMovie(completion: @escaping ([Movie])->Void){
        APICaller.shared.getUpcommingMovies { (MoviesResult) in
           
            switch MoviesResult {
            case .success(let movies) :
                completion(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTopRatedgMovie(completion: @escaping ([Movie])->Void){
        APICaller.shared.getTopRated { (MoviesResult) in
           
            switch MoviesResult {
            case .success(let movies) :
                completion(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
