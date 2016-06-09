//
//  QuoteTVC.swift
//  Quote Pro
//
//  Created by Anthony Coelho on 2016-06-08.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

import UIKit

class QuoteTVC: UITableViewCell {

    @IBOutlet weak var quoteImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
