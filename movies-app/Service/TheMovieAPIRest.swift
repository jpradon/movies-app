//
//  TheMovieAPIRest.swift
//  movies-app
//
//  Created by training on 29-06-22.
//

import Foundation
import Foundation
import Alamofire

class TheMovieAPIRest {
    
    // MARK: Properties
    let url_base: String = "https://api.themoviedb.org/3/movie"
    let token: String = "6aedc7e1349584ac9224e8d9670af8a8"

    //MARK: Method Register
    func popularMovie(page: Int, complete : @escaping (_ status : APIStatusType, _ messsage: PopularMovieResponse?) -> ()) {
        
        let context = "\(url_base)/popular?api_key=\(token)&language=en-US&page=\(page)"
        
        print(context)
        
        AF.request(context).response { response in
            
            print ("response:")
            debugPrint(response)
            
            if response.error != nil {
                complete(.api_call_error,nil)
                return
            }

            guard let data = response.data else {
                complete(.no_data,nil)
                return
            }
            
            do {
                let popularMovieResponse = try JSONDecoder().decode(PopularMovieResponse.self, from: data)
                print("*** resultado ***\n")
                print("page: \(popularMovieResponse.page)")
                print("total pages: \(popularMovieResponse.totalPages)")
                
                if (popularMovieResponse.success ?? true) {
                    complete(.success, popularMovieResponse)
                    return
                } else {
                    complete(.unsuccessfully,nil)
                    return
                }
               
            } catch let error {
                print(error)
                complete(.error_processing_content, nil)
                return
            }
         }
    }

}
