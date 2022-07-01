//
//  ShareFeatureViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/20/22.
//

import UIKit
import SwiftUI

class ShareFeatureViewController: UIViewController{
    
    @IBOutlet weak var directionsbutton: UIButton!
    @IBOutlet weak var sharebutton: UIButton!
    @IBOutlet weak var sitedescription: UITextView!
    @IBOutlet weak var locImage: UIImageView!
    
    var sitedesc = ""
    var locImg = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        sitedescription.text = sitedesc
        
    }
}
