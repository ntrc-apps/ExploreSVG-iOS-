//
//  TourOperatorsViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 4/28/22.
//

import UIKit
import SwiftUI
import SDWebImage

class TourViewTableViewCell: UITableViewCell {

    @IBOutlet weak var tourTitleView: UITextView!
    @IBOutlet weak var tourImageHolder: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        
    tourImageHolder.layer.cornerRadius = 5.0
    tourImageHolder.layer.masksToBounds = true
  
}
    
}
    class TourOperatorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
        
   
        
        struct tourCategory
        {
            var categoryId: Int = 0
            var categoryName: String? = nil
            var categoryImage: String? = nil
            var displayid: Int = 0
        }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var toolbar3: UIToolbar!
    @IBOutlet weak var tourtableview: UITableView!
    @IBOutlet weak var gradientView: UIView!
        
        var tour: [tourCategory] = []
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
        
        view.addSubview(mainView)
        view.addSubview(toolbar3)
        ParseTourData()
       

        tourtableview.delegate = self
        tourtableview.dataSource = self
        
        let layer = CAGradientLayer()
               layer.frame = view.bounds
               layer.colors = [UIColor.white.cgColor, UIColor.link.cgColor]
               gradientView.layer.addSublayer(layer)
        
        title = "Tour Operators"
    }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tour.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tourtableview.dequeueReusableCell(withIdentifier: "tourCell", for: indexPath)as!TourViewTableViewCell
    //
            let serverurl=NSURL(string: "https://cert-manager.ntrcsvg.com/tourism/getTourOperators.php")
                let imageaddress = tour[indexPath.row].categoryImage
            let imageURL = NSURL.init(string: imageaddress!, relativeTo: serverurl! as URL)
                cell.tourImageHolder?.sd_setImage(with: imageURL! as URL )
            
            
            //cell.imageholder?.image = attractions[indexPath.row].categoryImage
                cell.tourTitleView?.text = tour[indexPath.row].categoryName
    //
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "seg1", sender: self)
            
}

        




    
    
    func ParseTourData(){
        
        tour = []

    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourOperators.php")
        
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
            let tourData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
            print(tourData)
            
            for i in 0...tourData.count-1{
                let data = tourData[i]
                
                var tourCat = tourCategory()
                
                //var getAttraction = data
                tourCat.categoryId = Int(((data as! NSDictionary)["tourguide_id"] as? String)!)!
                tourCat.categoryName = (data as! NSDictionary)["tourguide_name"] as? String
                tourCat.categoryImage = (data as! NSDictionary)["tourimageurl"] as? String
                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
                
                
                self.tour.append(tourCat)
                
                
                
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
                self.tourtableview.reloadData()
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


