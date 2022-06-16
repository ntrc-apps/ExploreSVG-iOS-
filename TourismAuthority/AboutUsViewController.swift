//
//  AboutUsViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/5/22.
//

import UIKit
import SwiftUI

class AboutUsViewController: UIViewController{
    @IBOutlet weak var textviewholder: UIView!
    override func viewDidLoad() {
        
    super.viewDidLoad()
        view.addSubview(textviewholder)
        title = "About Us"
    }
}
