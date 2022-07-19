//
//  TourFragmentViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 6/20/22.
//

import UIKit
import SwiftUI
import SDWebImage

    class TourFragmentViewController: UIViewController{

        
        
        @IBOutlet weak var DescriptionView: UITextView!
        
        @IBOutlet weak var titleHolder: UIView!
        @IBOutlet weak var desimage: UIImageView!
        @IBOutlet weak var Titlename: UITextView!
        @IBOutlet weak var destination: UITextView!
        @IBOutlet weak var openinghours: UITextView!
        @IBOutlet weak var numberphone: UITextView!
        @IBOutlet weak var weblink: UITextView!
        @IBOutlet weak var location: UITextView!
        
        
        var imageURL : String?
        var nameTitle = ""
        var destinationtitle = ""
        var hours = ""
        var phonenumber = ""
        var linkweb = ""
        var loc = ""
  
        
    override func viewDidLoad() {
    super.viewDidLoad()

//        }
        self.desimage.sd_setImage(with: URL(string:imageURL!), placeholderImage: UIImage(named: "ntrclogofinal.png"),options: SDWebImageOptions(), completed: {(image, error, cacheType, imageURL) -> Void in
                           print("image loaded")
                       })
        location.text = loc
        Titlename.text = nameTitle
        DescriptionView.text = destinationtitle
        openinghours.text = hours
        numberphone.text = phonenumber
        weblink.text = linkweb
        
        DescriptionView.layer.cornerRadius = 10.0
        DescriptionView.layer.masksToBounds = true

        titleHolder.layer.cornerRadius = 5.0
        titleHolder.layer.masksToBounds = true

        title = "Tours"
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
