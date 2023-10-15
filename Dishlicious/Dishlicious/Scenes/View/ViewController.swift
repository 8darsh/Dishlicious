//
//  ViewController.swift
//  Dishlicious
//
//  Created by Adarsh Singh on 07/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var headerView: UIView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.searchBar.layer.cornerRadius = 15
        
    }

    @IBAction func filterBtnTapped(_ sender: UIButton) {
    }
    
}

