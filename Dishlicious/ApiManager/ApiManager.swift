//
//  ApiManager.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 09/10/23.
//

import Foundation
enum DataError:Error{
    
    case invalidResponse
    case invalidUrl
    case invalidData
    case network(Error?)
}
typealias Handler<T> = (Result<T, DataError>)->Void

class ApiManager:Codable{
    public var searchQuery: String = ""
    static let shared = ApiManager()
    init(){}
    
    func updateSearchQuery(query: String, completion: @escaping Handler<DishModel>) {
        // Create an endpoint or URL based on the search query
        searchQuery = query
        let searchEndPoint = DataEndPoint.dish(searchString: query)
        
        
        // Call the request function to perform the search
        request(modelType: DishModel.self, type:searchEndPoint, completion: completion)
    }
    
    func request<T: Codable>(
    
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ){
        guard let url = type.url else{
            completion(.failure(.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let parameters = type.body{
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        
        request.allHTTPHeaderFields = type.headers
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data, error == nil else{
                completion(.failure(.invalidData))
                return
            }
        
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else{
                
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                
                let product = try JSONDecoder().decode(modelType, from: data)
                completion(.success(product))
                
            }catch{
                completion(.failure(.network(error)))
            }
            
        }.resume()
    
    }
    static var commonHeader: [String:String]{
        return [
            "cache-control": "private",
            "connection": "keep-alive",
            "content-encoding": "gzip",
            "content-language": "en",
            "content-type": "application/json",
            "date": "Mon, 09 Oct 2023 09:38:56 GMT",
            "expires": "Thu, 01 Jan 1970 00:00:00 GMT",
            "server": "openresty",
            "strict-transport-security": "max-age=15552001",
            "transfer-encoding": "chunked",
            "vary": "accept-encoding",
            "x-envoy-upstream-service-time": "284",
            "x-request-id": "5813b4d7fe63d5edf64d04ec506fbedb",
            "x-served-by": "ip-10-0-1-251.ec2.internal/10.0.1.251"
        
        ]
    }
}
