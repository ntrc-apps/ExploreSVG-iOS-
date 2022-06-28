//
//  ContactUsViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/5/22.
//

import UIKit
import SwiftUI

class ContactUsViewController: UIViewController{
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var gradientview: UIView!
    
    override func viewDidLoad() {
     
        
    super.viewDidLoad()
        view.addSubview(mainview)
        print("make my shit straight bitch ass nigga")
        let layer = CAGradientLayer()
               layer.frame = view.bounds
               layer.colors = [UIColor.white.cgColor,UIColor.white.cgColor,UIColor.white.cgColor,UIColor.white.cgColor, UIColor.link.cgColor]
               gradientview.layer.addSublayer(layer)
        
        title = ""
    }
}
