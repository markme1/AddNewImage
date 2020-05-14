//
//  FirstCell.swift
//  Add New Image
//
//  Created by mark me on 3/25/20.
//  Copyright © 2020 mark me. All rights reserved.
//

import UIKit

class FirstCell: UITableViewCell {
    
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var mainLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImage.layer.cornerRadius = mainImage.bounds.width/2
        
        
        
    }
    
}
