//
//  ResultsViewController.swift
//  BMSTU Lib
//
//  Created by Nikita Balikhin on 11.03.2018.
//  Copyright © 2018 LandSlide. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

struct Book {
    var name: String?
    var id: Int?
}

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var books = [Book]()
    
    private var _query: String!
    var query:String {
        get {
            return _query
        }        
        set {
            _query = newValue
        }
    }
    
    @IBOutlet weak var queryLabel: UILabel!
    
    @IBOutlet weak var bmstuLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadSearchResults {
            
        }
        
        queryLabel.text = query
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        // bmstuLogo.isUserInteractionEnabled = true
        bmstuLogo.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        dismiss(animated: true, completion: nil)
        
        // Your action
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell {
            cell.configureCell(name: books[indexPath.row].name!, bookId: books[indexPath.row].id!)
            cell.selectedBackgroundView?.backgroundColor = UIColor.init(red: 243, green: 195, blue: 128, alpha: 1)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped(tapGestureRecognizer:)))
            cell.addGestureRecognizer(tapGestureRecognizer)
            return cell
        } else {
            return BookCell()
        }
        
    }
    
    @objc func cellTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "showBook", sender: tapGestureRecognizer.view)
    }
    
    func downloadSearchResults(completed: @escaping DownloadComplete) {

        let str = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let searchURL = URL(string: "\(SEARCH_URL)\(str)")!
        Alamofire.request(searchURL, method: .get).response { (response) in
            let bookList = SWXMLHash.parse(response.data!)["ArrayOfLibCatalogRecord"]["LibCatalogRecord"].all
            for item in bookList {
                var book = Book()
                book.name = (item["BibDescriptionText"].element?.text)!
                book.id = Int((item["RecordId"].element?.text)!)!
                self.books.append(book)
            }
            self.tableView.reloadData()
            completed()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookViewController {
            if let book = sender as? BookCell {
                destination.id = book.id
            }
        }
    }

}
