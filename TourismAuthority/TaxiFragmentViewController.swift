//
//  AboutUsViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/5/22.
//

import UIKit
import SwiftUI

class TaxiFragmentViewTableViewCell: UITableViewCell {

    @IBOutlet weak var OperatorInfo: UITextView!
    @IBOutlet weak var OperatorTitle: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        OperatorInfo.layer.cornerRadius = 5.0
        OperatorInfo.layer.masksToBounds = true
        
       
    }
}

class TaxiFragmentViewController: UIViewController{
    @IBOutlet weak var OperatorTable: UITableView!
    
 
    override func viewDidLoad() {

    super.viewDidLoad()
        title = "Taxi Operators"
    }
}

