//
//  DataEndPoint.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 09/10/23.
//

import Foundation

enum DataEndPoint{
    
    case dish(searchString: String)
}

//https://api.edamam.com/api/recipes/v2?type=public&beta=false&q=veg&app_id=f6a9002a&app_key=d11d8820e5aa004c7bcf0e4c540fdadd&random=true
extension DataEndPoint:EndPointType{
    var path: String {
        switch self {
        case .dish(searchString: let searchString):
            if searchString == ""{
                return "veg&app_id=f6a9002a&app_key=d11d8820e5aa004c7bcf0e4c540fdadd&random=true"
            }else{
                return "\(searchString)&app_id=f6a9002a&app_key=d11d8820e5aa004c7bcf0e4c540fdadd&random=true"
            }
        }
    }
    
    var baseURL: String {
        switch self {
        case .dish:
            return "https://api.edamam.com/api/recipes/v2?type=public&beta=false&q="
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .dish:
            return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .dish:
            return nil
        }
    }
    
    var headers: [String : String]? {
        ApiManager.commonHeader
    }
    
    
}
