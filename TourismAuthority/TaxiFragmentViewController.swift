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
        
//        OperatorTitle.layer.cornerRadius = 5.0
//        OperatorTitle.layer.masksToBounds = true
        
       
    }
}

class TaxiFragmentViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  OperatorTable.dequeueReusableCell(withIdentifier: "TaxiFragmentTableViewCell", for: indexPath)as!TaxiFragmentViewTableViewCell
        
        return cell
    }
    
    @IBOutlet weak var OperatorTable: UITableView!
    
 
    override func viewDidLoad() {
        
        OperatorTable.delegate = self
        OperatorTable.dataSource = self

    super.viewDidLoad()
        title = ""
    }
    
    
}

