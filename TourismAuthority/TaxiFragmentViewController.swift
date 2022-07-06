//
//  AboutUsViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/5/22.
//

import UIKit
import SwiftUI
import SDWebImage

//class TaxiFragmentViewTableViewCell: UITableViewCell {
//
//
//    @IBOutlet weak var TitleLabel: UITextView!
//    @IBOutlet weak var TitleHolder: UIView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        TitleHolder.layer.cornerRadius = 5.0
//        TitleHolder.layer.masksToBounds = true
//    }
//}

class TaxiFragmentViewController: UIViewController {
    
//    struct TaxiOperator
//        {
//            var OperatorId: Int = 0
//            var OperatorName: String? = nil
//            var OperatorImage: String? = nil
//            var OperatorNumber: Int = 0
//        }
//
//    var TaxiOperators: [TaxiOperator] = []
//
//    @IBOutlet weak var OperatorTable: UITableView!
//    @IBOutlet weak var MainView: UIView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview()
//
////        TaxiFragmentParseData()
////
////        TaxiFragmentTableView.dataSource = self
////        TaxiFragmentTableView.delegate = self

        
    @IBOutlet weak var DesImage: UIImageView!
    @IBOutlet weak var TaxiName: UITextView!
    @IBOutlet weak var number: UITextView!
    @IBOutlet weak var location: UITextView!
    
    var OperatorId = ""
    var OperatorName = ""
    var imageURL : String?
    var OperatorNumber = ""
    var OperatorWebsite = ""
    var OperatorLocation = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
        self.DesImage.sd_setImage(with: URL(string:imageURL!), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(), completed: {(image, error, cacheType, imageURL) -> Void in
                           print("image loaded")
                       })
        TaxiName.text = OperatorName
        number.text = OperatorNumber
        location.text = OperatorLocation
  
        
        
        
////
//        title = "Taxi Operator"
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell =  OperatorTable.dequeueReusableCell(withIdentifier: "TaxiFragmentTableViewCell", for: indexPath)as!TaxiFragmentViewTableViewCell
////        let serverurl=NSURL(string: "https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
////            let imageaddress = TaxiOperator[indexPath.row].OperatorImage
////        let imageURL = NSURL.init(string: imageaddress!, relativeTo: serverurl! as URL)
////            cell.WhatToDoFragmentBackgroundImage?.sd_setImage(with: imageURL! as URL )
////
////
////        //cell.WhatToDoFragmentBackgroundImage?.image = WhatToDoList[indexPath.row].ListBackgroudImage
////            cell.WhatToDoFragmentTitleView?.text = WhatToDoList[indexPath.row].ListName
////////
////        return cell
//
//
//        return cell
//    }
//
    //@IBOutlet weak var OperatorTable: UITableView!
    
 
//    override func viewDidLoad() {
//
//        OperatorTable.delegate = self
//        OperatorTable.dataSource = self
//
//    super.viewDidLoad()
//        title = ""
//    }
//
    
    
}

