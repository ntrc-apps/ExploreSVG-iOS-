//
//  TourFragmentViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 6/20/22.
//

import UIKit
import SwiftUI

class TourFragmentViewController: UIViewController{
    
    
    @IBOutlet weak var TitleHolder: UIView!
   
    @IBOutlet weak var descriptionView: UITextView!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        TitleHolder.layer.cornerRadius = 5.0
        TitleHolder.layer.masksToBounds = true
        
        descriptionView.layer.cornerRadius = 5.0
        descriptionView.layer.masksToBounds = true
        
//        let layer = CAGradientLayer()
//               layer.frame = view.bounds
//               layer.colors = [UIColor.white.cgColor,UIColor.white.cgColor, UIColor.link.cgColor]
//               GradientView.layer.addSublayer(layer)
//        
        
    }
}
