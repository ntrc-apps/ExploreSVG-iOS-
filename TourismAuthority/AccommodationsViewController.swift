//
//  Accommodations.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 4/28/22.
//

import UIKit
import SwiftUI
import SDWebImage

class AccommodationsViewTableViewCell: UITableViewCell {

    @IBOutlet weak var accommodationsTitleView: UITextView!
    @IBOutlet weak var accommodationsImageHolder: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        
        accommodationsImageHolder.layer.cornerRadius = 5.0
        accommodationsImageHolder.layer.masksToBounds = true
  
}
}
class AccommodationsViewController: UIViewController{
    
    @IBOutlet weak var toolbar2: UIToolbar!
    @IBOutlet weak var toolbar1: UIToolbar!
    @IBOutlet weak var toolbar3: UIToolbar!
    @IBOutlet var view3: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var accommodationstableview: UITableView!
    
    struct AccommodationsCategory
    {
        var categoryId: Int = 0
        var categoryName: String? = nil
        var categoryImage: String? = nil
        var displayid: Int = 0
    }
    
    var accommodation: [AccommodationsCategory] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        view.addSubview(mainView)
        view.addSubview(toolbar3)
        ParseAccommodationsData()
        
        accommodationstableview.delegate = self
        accommodationstableview.dataSource = self
        
        let layer = CAGradientLayer()
               layer.frame = view.bounds
               layer.colors = [UIColor.white.cgColor, UIColor.link.cgColor]
               gradientView.layer.addSublayer(layer)
        
        title = "Accommodations"
    }
}
extension AccommodationsViewController: UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
        

}

extension AccommodationsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accommodation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = accommodationstableview.dequeueReusableCell(withIdentifier: "accommodationCell", for: indexPath)as!AccommodationsViewTableViewCell
//
        let serverurl=NSURL(string: "https://cert-manager.ntrcsvg.com/tourism/getAccommodations.php")
            let imageaddress = accommodation[indexPath.row].categoryImage
        let imageURL = NSURL.init(string: imageaddress!, relativeTo: serverurl! as URL)
            cell.accommodationsImageHolder?.sd_setImage(with: imageURL! as URL )
        
        
        //cell.imageholder?.image = attractions[indexPath.row].categoryImage
            cell.accommodationsTitleView?.text = accommodation[indexPath.row].categoryName
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }


func ParseAccommodationsData(){
    
    accommodation = []

let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getAccommodations.php")
    
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
        let accommodationData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
        print(accommodationData)
        
        for i in 0...accommodationData.count-1{
            let data = accommodationData[i]
            
            var accommodationsCat = AccommodationsCategory()
            
            //var getAttraction = data
            //tourCat.categoryId = Int(((data as! NSDictionary)["tourguide_id"] as? String)!)!
            accommodationsCat.categoryName = (data as! NSDictionary)["sitename"] as? String
            accommodationsCat.categoryImage = (data as! NSDictionary)["image"] as? String
            //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
            
            
            self.accommodation.append(accommodationsCat)
            
            
            
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
            self.accommodationstableview.reloadData()
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
