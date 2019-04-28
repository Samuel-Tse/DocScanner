//
//  MainTableViewCell.swift
//  DocScanner
//
//  Created by Samuel Tse on 26/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView_Doc: UIImageView!
    @IBOutlet weak var label_DocName: UILabel!
    @IBOutlet weak var label_DocCreatedDT: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
