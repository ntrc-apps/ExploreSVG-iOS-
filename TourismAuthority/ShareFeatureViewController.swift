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
    
    
    
    @IBAction func directionsButton(_ sender: UIButton) {
        print("tapped")
        }
        
    
    @IBOutlet weak var SiteTitle: UITextField!
    @IBOutlet weak var sharebutton: UIButton!
    @IBOutlet weak var sitedescription: UITextView!
    @IBOutlet weak var locImage: UIImageView!
    
    var sitedesc = ""
    var siteTite = ""
    var imageURL : String? = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
     
        
        self.locImage?.sd_setImage(with: URL(string:imageURL!), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(), completed: {(image, error, cacheType, imageURL) -> Void in
                           print("image loaded")
                       })
        sitedescription.text = sitedesc
        SiteTitle.text = siteTite
        
        title = "What To Do"
    }
}
