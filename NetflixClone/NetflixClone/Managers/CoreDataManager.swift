//
//  CoreDataManager.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 06/04/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    enum DatabaseError : Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    //MARK:- Dowload Movie To Database
    func downloadMovie(model: Movie, completion: @escaping (Result<Void,Error>)->Void)  {
        // refrence to app delegate
     
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context =  appDelegate.persistentContainer.viewContext
        
        let item = MovieItem(context: context)
        
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.overview = model.overview
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
       
        do {
       try  context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
   
    }
    
    //MARK:- Fetch All Movies Item Form Database
    func fetchMoviesFormDatabase(completion: @escaping (Result<[MovieItem], Error>)->Void)  {
      
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context =  appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<MovieItem>
        request = MovieItem.fetchRequest()
        
        do{
            let movieItems = try context.fetch(request)
            completion(.success(movieItems))
        }catch {
            completion(.failure(DatabaseError.failedToFetchData))
            
        }
        
    }
    
    //MARK:- Delete Movie From CoreData
    func deleteMovie(model : MovieItem, completion: @escaping (Result<Void,Error>)->Void)  {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context =  appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
       try  context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
        
    }
    
  
    
    
}
