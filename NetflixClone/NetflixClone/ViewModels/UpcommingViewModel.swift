//
//  UpcommingViewModel.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import Foundation

class UpcommingMoviesViewModel {
   
    var upcommingMovies : [Movie] = []

    func getUpcommingMovies(completion: @escaping (Bool)->Void)  {
        APICaller.shared.getUpcommingMovies { (moviesResult) in
            
            switch moviesResult {
            case .success(let movies) :
                self.upcommingMovies = movies
                completion(true)

            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
}


