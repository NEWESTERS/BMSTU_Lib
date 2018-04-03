//
//  BookCell.swift
//  BMSTU Lib
//
//  Created by Nikita Balikhin on 15.03.2018.
//  Copyright © 2018 LandSlide. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    var id: Int!
    
    func configureCell(name: String, bookId: Int) {
        self.nameLabel.text = name
        self.id = Int(bookId)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
