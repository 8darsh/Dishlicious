//
//  EndPointType.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 09/10/23.
//

import Foundation

enum HTTPMethods: String{
    case get = "GET"
    
}

protocol EndPointType{
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    
    var method: HTTPMethods { get }
    var body: Encodable? {get}
    var headers: [String:String]? {get}
}
