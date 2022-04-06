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
        static let youtube_API_KEY = "AIzaSyCGusUZKfChyH0RGyiIZ6SsqxHmcHRGUfE"
       static let youtube_BaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
        //https://youtube.googleapis.com/youtube/v3/search?key=[YOUR_API_KEY]

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
    
    //MARK:- Discovered Movies
    func getDiscoverdMovies(completion : @escaping (Result<[Movie], Error>)->Void)  {
    
        guard let url = URL(string:         "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
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
    
    //MARK:- Search With query
    func searchMovies(query : String,completion : @escaping (Result<[Movie], Error>)->Void)  {
        guard let filteredQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
   
        guard let url = URL(string:         "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(filteredQuery)") else {
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
    
    
    //MARK:- Search With query
    func getYoutubeMovie(query : String, completion : @escaping (Result<VideoElement, Error>)->Void)  {
        
        guard let filteredQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
   
        
        
        guard let url = URL(string:  "\(Constants.youtube_BaseUrl)q=\(filteredQuery)&key=\(Constants.youtube_API_KEY)") else {
     
            return
        }
     
        
        let task =  URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else  {
                
                return}
            
            do {
                let result = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                completion(.success(result.items[0]))
            }catch {
                
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
        
    }

}
