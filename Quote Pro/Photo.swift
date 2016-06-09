//
//  Photo.swift
//  Quote Pro
//
//  Created by Anthony Coelho on 2016-06-08.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

import Foundation
import UIKit

class Photo: NSObject {
    
    var image: UIImage
    var id: Int
    
    init(id: Int, image: UIImage) {
        self.image = image
        self.id = id
        
    }


}
