//
//  APICaller.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import Foundation

class APICaller {
    
    static let shared  =  APICaller()
    
    struct Constants {
       static let API_KEY = "78bca5a77288aadbe46acb53c5cf6e5b"
        static let baseUrl = "https://api.themoviedb.org"
       // https://api.themoviedb.org/3/trending/all/day?api_key=78bca5a77288aadbe46acb53c5cf6e5b
        //https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1
        //https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
        //https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1
    }

    enum APIError :Error  {
        case faildToGetData
    }
    
//MARK:- Trending Movies
    
    func getTrendingMovies(completion : @escaping (Result<[Movie], Error>)->Void)  {
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {
            return
        }
        
        let task =  URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else  {return}
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.faildToGetData))
            }
            
        }
        task.resume()
        
    }
    
    //MARK:- Trending TV
    func getTrendingTv(completion : @escaping (Result<[Movie], Error>)->Void)  {
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {
            return
        }
        
        let task =  URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else  {return}
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.faildToGetData))            }
            
        }
        task.resume()
        
    }
    
    //MARK:- Upcomming Movies
    func getUpcommingMovies(completion : @escaping (Result<[Movie], Error>)->Void)  {
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            return
        }
        
        let task =  URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else  {return}
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.faildToGetData))            }
            
        }
        task.resume()
        
    }
    
    //MARK:- Popular Movies
    func getPopularMovies(completion : @escaping (Result<[Movie], Error>)->Void)  {
        

        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            return
        }
        
        let task =  URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else  {return}
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.faildToGetData))            }
            
        }
        task.resume()
        
    }
    
    //MARK:- Top Rated
    
    func getTopRated(completion : @escaping (Result<[Movie], Error>)->Void)  {
        

        guard let url = URL(string:         "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            return
        }
        
        let task =  URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else  {return}
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.faildToGetData))            }
            
        }
        task.resume()
        
    }

    

}
