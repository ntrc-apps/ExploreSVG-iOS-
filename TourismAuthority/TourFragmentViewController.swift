//
//  TourFragmentViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 6/20/22.
//

import UIKit
import SwiftUI
import SDWebImage

//class TourFragmentViewTableViewCell: UITableViewCell {
//
//    @IBOutlet weak var DescriptionView: UITextView!
//
//    @IBOutlet weak var Titlename: UITextView!
//    @IBOutlet weak var destination: UITextView!
//    @IBOutlet weak var openinghours: UITextView!
//    @IBOutlet weak var numberphone: UITextView!
//    @IBOutlet weak var weblink: UITextView!
//
//    var nameTitle = ""
//    var destinationtitle = ""
//    var hours = ""
//    var phonenumber = ""
//    var linkweb = ""
//
//
//    override func awakeFromNib() {
//            super.awakeFromNib()
//
//        DescriptionView.layer.cornerRadius = 5.0
//        DescriptionView.layer.masksToBounds = true
//
//        Titlename.text = nameTitle
//        DescriptionView.text = destinationtitle
//        openinghours.text = hours
//        numberphone.text = phonenumber
//        weblink.text = linkweb
//}


    
    class TourFragmentViewController: UIViewController{

        
        
        @IBOutlet weak var DescriptionView: UITextView!
        
        @IBOutlet weak var desimage: UIImageView!
        @IBOutlet weak var Titlename: UITextView!
        @IBOutlet weak var destination: UITextView!
        @IBOutlet weak var openinghours: UITextView!
        @IBOutlet weak var numberphone: UITextView!
        @IBOutlet weak var weblink: UITextView!
        
        var desimages = UIImage()
        var nameTitle = ""
        var destinationtitle = ""
        var hours = ""
        var phonenumber = ""
        var linkweb = ""
        
        @IBOutlet weak var tourFragmentTableView: UITableView!
        
    override func viewDidLoad() {
    super.viewDidLoad()

//        }
        
        Titlename.text = nameTitle
        DescriptionView.text = destinationtitle
        openinghours.text = hours
        numberphone.text = phonenumber
        weblink.text = linkweb
        desimage.image = desimages
        
       
        
//        let layer = CAGradientLayer()
//               layer.frame = view.bounds
//               layer.colors = [UIColor.white.cgColor,UIColor.white.cgColor, UIColor.link.cgColor]
//               GradientView.layer.addSublayer(layer)
//        
        
    }
        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return 1
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell =  tourFragmentTableView.dequeueReusableCell(withIdentifier: "TourFragmentTableCell", for: indexPath)
//
//            return cell
//        }
//}

    }
