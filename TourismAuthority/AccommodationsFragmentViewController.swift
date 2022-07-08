//
//  AccommodationsFragmentViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 6/29/22.
//

import UIKit
import SwiftUI
import SDWebImage

class AccommodationsFragmentViewController: UIViewController{
    
    @IBOutlet weak var accimg: UIImageView!
    @IBOutlet weak var descView: UITextView!
    @IBOutlet weak var desTitle: UITextView!
    @IBOutlet weak var phoneNum: UITextView!
    
    var imageURL : String?
    var desView = ""
    var destinationtitle = ""
    var phonenumber = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
        title = "Accommodations"
        
        self.accimg.sd_setImage(with: URL(string:imageURL!), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(), completed: {(image, error, cacheType, imageURL) -> Void in
                           print("image loaded")
                       })
        desTitle.text = destinationtitle
        descView.text = desView
        phoneNum.text = phonenumber
        
        
        accimg.layer.cornerRadius = 5.0
        accimg.layer.masksToBounds = true
    }
}

