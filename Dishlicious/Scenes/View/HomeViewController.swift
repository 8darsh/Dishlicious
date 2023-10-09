//
//  HomeViewController.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 09/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var headerView: UIView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    var viewModel = DishViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.headerView.layer.cornerRadius = 25
 
        configuration()
    }
    
}
extension HomeViewController{
    
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
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dish?.hits.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! HotRecipesTableViewCell
        let dish = viewModel.dish?.hits[indexPath.row]
        cell.dishName.text = dish?.recipe.label
        cell.cuisineType.text = dish?.recipe.cuisineType?[0]
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "detailRecipesViewController") as! detailRecipesViewController
        let recipe = viewModel.dish?.hits[indexPath.row].recipe
        vc.dish = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dish?.hits.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!
        TrendDishCollectionViewCell
        let dish = viewModel.dish?.hits[indexPath.row]
        cell.dishName.text = dish?.recipe.label
        
        cell.calories.text = String(Int(dish?.recipe.calories ?? 1) as Int ) as String
        cell.cuisineType.text = dish?.recipe.cuisineType?[0]
        cell.dietLabels.text = dish?.recipe.dietLabels?.first
        cell.mealType.text = dish?.recipe.mealType[0]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "detailRecipesViewController") as! detailRecipesViewController
        let recipe = viewModel.dish?.hits[indexPath.row].recipe
        vc.dish = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
