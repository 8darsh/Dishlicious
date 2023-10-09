//
//  DishViewModel.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 09/10/23.
//

import Foundation
import UIKit

final class DishViewModel{
    var dish: DishModel?
    var eventHandler:((_ event: Event)->Void)?
    func fetchdata(){
        self.eventHandler?(.loading)
        let searchQuery = ApiManager.shared.searchQuery
        ApiManager.shared.request(modelType: DishModel.self, type: DataEndPoint.dish(searchString: searchQuery)) { response in
            self.eventHandler?(.stopLoading)
            switch response{
                
            case .success(let dish):
                self.dish = dish
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
}
extension DishViewModel{
    enum Event{
        
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        
    }
}
