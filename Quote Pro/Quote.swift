//
//  Quote.swift
//  Quote Pro
//
//  Created by Anthony Coelho on 2016-06-08.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

import Foundation
import UIKit


class Quote: NSObject {
    
 
    
    var quoteText: String
    var quoteImage: UIImage
    
    init(quoteText: String, image: UIImage) {
        self.quoteText = quoteText
        self.quoteImage = image
    }

}
