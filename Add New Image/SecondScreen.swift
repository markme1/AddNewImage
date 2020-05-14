//
//  SecondScreen.swift
//  Add New Image
//
//  Created by mark me on 3/25/20.
//  Copyright © 2020 mark me. All rights reserved.
//

import UIKit

class SecondScreen: UIViewController {
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var secondLable: UILabel!
    
    var newlabel: String!
    var newimage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondImage.layer.cornerRadius = 25
        secondImage.layer.masksToBounds = true
        secondLable.layer.cornerRadius = 10
        secondLable.layer.masksToBounds = true
        
        secondLable.text = newlabel
        secondImage.image = newimage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
