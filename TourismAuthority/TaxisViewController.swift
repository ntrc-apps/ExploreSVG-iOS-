//
//  TaxisViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 4/28/22.
//

import UIKit
import SwiftUI

class TaxisViewTableViewCell: UITableViewCell {

    @IBOutlet weak var taxiTitleView: UITextView!
    @IBOutlet weak var taxiImageHolder: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        
        taxiImageHolder.layer.cornerRadius = 5.0
        taxiImageHolder.layer.masksToBounds = true
  
}
}
class TaxisViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    struct TaxiCategory
    {
        var categoryId: Int = 0
        var categoryName: String? = nil
        var categoryImage: String? = nil
        var categoryNumber: String? = nil
        var categoryLocation: String? = nil
        var displayid: Int = 0
    }
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var taxitableview: UITableView!
    @IBOutlet weak var gradientview: UIView!
    @IBOutlet weak var toolbar3: UIToolbar!
    
    var taxi: [TaxiCategory] = []
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
        
        view.addSubview(mainview)
        ParseTaxiData()
        
        taxitableview.delegate = self
        taxitableview.dataSource = self
        
        let layer = CAGradientLayer()
               layer.frame = view.bounds
               layer.colors = [UIColor.white.cgColor, UIColor.link.cgColor]
               gradientview.layer.addSublayer(layer)
        
        title = "Taxis"
    }


   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxi.count
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = taxitableview.dequeueReusableCell(withIdentifier: "taxicell", for: indexPath)as!TaxisViewTableViewCell
        let serverurl=NSURL(string: "https://cert-manager.ntrcsvg.com/tourism/getTaxis.php")
            let imageaddress = taxi[indexPath.row].categoryImage
        let imageURL = NSURL.init(string: imageaddress!, relativeTo: serverurl! as URL)
        cell.taxiImageHolder?.sd_setImage(with: imageURL! as URL )
      
        
        
        //cell.imageholder?.image = attractions[indexPath.row].categoryImage
            cell.taxiTitleView?.text = taxi[indexPath.row].categoryName
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "TaxiFragmentViewController") as? TaxiFragmentViewController {
            
            let serverurl=NSURL(string: "https://cert-manager.ntrcsvg.com/tourism/getTaxis.php")
                let imageaddress = taxi[indexPath.row].categoryImage
            let imageURL = NSURL.init(string: imageaddress!, relativeTo: serverurl! as URL)
//            vc.desimages.sd_setImage(with: imageURL! as URL)
            vc.OperatorName = taxi[indexPath.row].categoryName!
            vc.OperatorNumber = taxi[indexPath.row].categoryNumber!
            vc.OperatorLocation = taxi[indexPath.row].categoryLocation!
            self.navigationController?.pushViewController(vc, animated: true)
        }
}
    

func ParseTaxiData(){
    
taxi = []

let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTaxis.php")
    
//creating NSMutableURLRequest
let request = NSMutableURLRequest(url: requestURL! as URL)
       
       //setting the method to post
request.httpMethod = "POST"
       
       //creating a task to send the post request
let session = URLSession.shared.dataTask(with: request as URLRequest){
           data, response, error in
           
           //exiting if there is some error
           if error != nil{
               print("error is \(String(describing: error))")
               return;
           }
           
           //parsing the response
    do {
                   //converting resonse to NSArray
        let data = try? Data(contentsOf: requestURL! as URL)
        let taxiData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
        print(taxiData)
        
        for i in 0...taxiData.count-1{
            let data = taxiData[i]
            
            var taxiCat = TaxiCategory()
            
            //var getAttraction = data
            taxiCat.categoryId = Int(((data as! NSDictionary)["taxi_id"] as? String)!)!
            taxiCat.categoryName = (data as! NSDictionary)["taxi_name"] as? String
            taxiCat.categoryNumber = (data as! NSDictionary)["taxi_number"] as? String
            taxiCat.categoryLocation = (data as! NSDictionary)["taxi_location"] as? String
            taxiCat.categoryImage = (data as! NSDictionary)["taxiimageurl"] as? String
            //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
            
            
            self.taxi.append(taxiCat)
            
            
            
//                let eachAttraction = data as! NSDictionary [String: Any]
//                let categoryId = eachAttraction["typeid"] as! Int
//                let categoryName = eachAttraction["sitedescription"] as? String
//                let categoryImage = UIImage(contentsOfFile: eachAttraction["image"] as! String)
//                let displayid = eachAttraction["display"] as! Int
//
//                self.attractions.append(attractionsCategory(categoryId: categoryId, categoryName: categoryName!, categoryImage: categoryImage!, displayid: displayid))
//
            
        }
      
        DispatchQueue.main.async {
            self.taxitableview.reloadData()
        }
        
//            for i in 0...locResponse.count-1 {
//                let data = locResponse[i]
//
//                //var attractionsCategory = attractionsCategory(categoryId: Int, categoryName: String, categoryImage: String, displayid: Int)
////                attractionsCategory.categoryId = (data as! NSDictionary)["typeid"] as? Int
////                attractionsCategory.categoryName = (data as! NSDictionary)["sitedescription"] as? String
////                attractionsCategory.categoryImage = (data as! NSDictionary)["image"] as? String
            
     
        
        }
    catch{
            do {
               print("error 2")
           }
       }
       //executing the task
       
}
session.resume()
}
}
