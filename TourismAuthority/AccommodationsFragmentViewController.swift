//
//  AccommodationsFragmentViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 6/29/22.
//

import UIKit
import SwiftUI

class AccommodationsFragmentViewController: UIViewController{
    
    @IBOutlet weak var accimg: UIImageView!
    @IBOutlet weak var descView: UITextView!
    @IBOutlet weak var desTitle: UITextView!
    @IBOutlet weak var phoneNum: UITextView!
    
    var accomimg = UIImage()
    var desView = ""
    var destinationtitle = ""
    var phonenumber = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        desTitle.text = destinationtitle
        descView.text = desView
        phoneNum.text = phonenumber
        accimg.image = accomimg
        
    }
}

