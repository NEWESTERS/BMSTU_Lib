//
//  BookViewController.swift
//  BMSTU Lib
//
//  Created by Nikita Balikhin on 16.03.2018.
//  Copyright © 2018 LandSlide. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

class BookViewController: UIViewController {

    var id: Int!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nameLabel.text = "Name"
        // authorLabel.text = "Author"
        // descriptionLabel.text = "Description"
        downloadBook {
            
        }
        
    }

    @IBAction func backButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadBook(completed: @escaping DownloadComplete) {
        let searchURL = URL(string: "\(BOOK_URL)\(id!)")!
        Alamofire.request(searchURL, method: .get).response { (response) in
            let book = SWXMLHash.parse(response.data!)["BibliographicResult"]
            self.nameLabel.text = book["Title"].element?.text
            self.authorLabel.text = book["Author"].element?.text
            self.descriptionText.text = book["Annotation"].element?.text
            
            completed()
        }
    }

}
