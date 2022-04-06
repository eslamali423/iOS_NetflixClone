//
//  YoutubeResponseViewModel.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 06/04/2022.
//

import Foundation


class YoutubeResponseViewModel {
    
    
    func getMovie (query : String, completion: @escaping (VideoElement)->Void){
        
        APICaller.shared.getYoutubeMovie(query: query) { (movieResult) in
            switch movieResult {
            case .success(let movie):
                completion(movie)
            case .failure(let error):
                print(error.localizedDescription)
            
            }
            
        }
        
    }
    
    
    
}
