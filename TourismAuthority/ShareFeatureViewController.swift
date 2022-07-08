//
//  ShareFeatureViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/20/22.
//

import UIKit
import SwiftUI
import SDWebImage

class ShareFeatureViewController: UIViewController{
    
    @IBOutlet weak var directionsbutton: UIButton!
    @IBOutlet weak var sharebutton: UIButton!
    @IBOutlet weak var sitedescription: UITextView!
    @IBOutlet weak var locImage: UIImageView!
    
    var sitedesc = ""
//    var locImg = ""
    var imageURL : String?
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        self.locImage.sd_setImage(with: URL(string:imageURL!), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(), completed: {(image, error, cacheType, imageURL) -> Void in
                           print("image loaded")
                       })
        sitedescription.text = sitedesc
        
    }
}
