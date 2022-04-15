//
//  BaseAPI.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 15/04/2022.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    
    func fetchData<M: Codable>(target : T, responseModel : M.Type, completion: @escaping (Result<M?, NSError>)->Void){
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let url = target.baseUrl + target.path
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params =  buildParams(task: target.task)
        
        AF.request(url, method: method, parameters: params.0, encoding: params.1, headers: headers ).responseJSON { (response) in
            
            guard let statusCode =  response.response?.statusCode else {
                completion(.failure(NSError()))
                return}
            
            if statusCode == 200 {
                
                guard let jsonResponse = try? response.result.get() else {
                    completion(.failure(NSError()))
                    return
                }
                
                guard  let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: [])  else {
                    completion(.failure(NSError()))
                    return
                }
                guard let jsonObject = try? JSONDecoder().decode(M.self, from: jsonData) else {
                    completion(.failure(NSError()))
                    return
                }
                
                completion(.success(jsonObject))
                
                
            
            
            }else {
                completion(.failure(NSError()))
            }
            
            
            
        }
        
        
    }
    
    private func buildParams(task : Task) -> ([String:Any], ParameterEncoding){
        switch task {
        
        case .requestPlain:
            return ([:], URLEncoding.default)

        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
}

}
