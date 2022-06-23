//
//  TourFragmentViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 6/20/22.
//

import UIKit
import SwiftUI

class TourFragmentViewTableViewCell: UITableViewCell {

    @IBOutlet weak var DescriptionView: UITextView!
    @IBOutlet weak var Title: UIView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        
        DescriptionView.layer.cornerRadius = 5.0
        DescriptionView.layer.masksToBounds = true
  
}

}
    
    class TourFragmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

        
        
  
        @IBOutlet weak var tourFragmentTableView: UITableView!
        
    override func viewDidLoad() {
    super.viewDidLoad()
        
    
        tourFragmentTableView.delegate = self
        tourFragmentTableView.dataSource = self
        
        
       
        
//        let layer = CAGradientLayer()
//               layer.frame = view.bounds
//               layer.colors = [UIColor.white.cgColor,UIColor.white.cgColor, UIColor.link.cgColor]
//               GradientView.layer.addSublayer(layer)
//        
        
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell =  tourFragmentTableView.dequeueReusableCell(withIdentifier: "TourFragmentTableCell", for: indexPath)as!TourFragmentViewTableViewCell
            
            return cell
        }
}

