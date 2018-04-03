//
//  ViewController.swift
//  BMSTU Lib
//
//  Created by Nikita Balikhin on 11.03.2018.
//  Copyright © 2018 LandSlide. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchField: UISearchBar!
    
    @IBAction func searchTap(_ sender: Any) {
        performSegue(withIdentifier: "search", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        searchField.layer.borderWidth = 1
        searchField.layer.borderColor = searchField.barTintColor?.cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchField.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "search", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ResultsViewController {
            destination.query = searchField.text!
        }
    }


}

