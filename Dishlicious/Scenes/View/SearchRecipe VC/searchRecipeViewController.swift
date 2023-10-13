//
//  searchRecipeViewController.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 13/10/23.
//

import UIKit

class searchRecipeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    var viewModel = DishViewModel()
    
    
    @IBOutlet var tableView: UITableView!
    let search = UISearchController(searchResultsController: nil)

    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarSetup()
        configuration()
    }
    

}
extension searchRecipeViewController{
    
    func searchBarSetup(){
        search.searchBar.delegate = self
        navigationItem.searchController = search
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dish?.hits.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HotRecipesTableViewCell
        let dish = viewModel.dish?.hits[indexPath.row]
        cell.dishName.text = dish?.recipe.label
        cell.cuisineType.text = dish?.recipe.cuisineType?[0]
        cell.dishImage.setImage(with: dish?.recipe.image ?? "hehe")
        cell.dishImage.layer.cornerRadius = 15
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        ApiManager.shared.updateSearchQuery(query: searchText) { [weak self] result in
            switch result{
                
            case .success(let dish):
                self?.viewModel.dish = dish
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension searchRecipeViewController{
    func configuration(){
        initViewModel()
        observeEvent()
    }
    
    func initViewModel(){
        viewModel.fetchdata()
        
    }
    func observeEvent(){
        
        viewModel.eventHandler = {
            [weak self] event in
            guard let self else {return}
            
            switch event{
                
            case .loading:
                print("Loading")
            case .stopLoading:
                print("Stop Loading")
            case .dataLoaded:
                print("Data Loaded")
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
