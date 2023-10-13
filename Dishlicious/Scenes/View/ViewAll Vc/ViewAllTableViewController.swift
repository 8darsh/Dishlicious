//
//  ViewAllTableViewController.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 14/10/23.
//

import UIKit

class ViewAllTableViewController: UITableViewController {
    
    var viewModel:DishViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.dish?.hits.count ?? 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! HotRecipesTableViewCell
        let dish = viewModel?.dish?.hits[indexPath.row]
        cell.dishName.text = dish?.recipe.label
        cell.cuisineType.text = dish?.recipe.cuisineType?[0]
        cell.dishImage.setImage(with: dish?.recipe.image ?? "hehe")
        cell.dishImage.layer.cornerRadius = 15
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "detailRecipesViewController") as! detailRecipesViewController
        let recipe = viewModel?.dish?.hits[indexPath.row].recipe
        vc.dish = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }

}

extension ViewAllTableViewController{
    func configuration(){
        observeEvent()
        initViewModel()
    }
    func initViewModel(){
        viewModel?.fetchdata()
    }
    
    func observeEvent(){
        
        viewModel?.eventHandler = { [weak self] event in
            guard let self else {return}
            switch event{
                
            case .loading:
                print("loading")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
}
