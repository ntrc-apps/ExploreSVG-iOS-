//
//  WhatToDoViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 4/26/22.
//

import UIKit
import SwiftUI
import SDWebImage

class WhatToDoViewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleview: UITextView!
    @IBOutlet weak var imageholder: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        
    imageholder.layer.cornerRadius = 5.0
    imageholder.layer.masksToBounds = true
  
}
}

class WhatToDoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
   
    
    
    var layer:CAGradientLayer!
    @IBOutlet var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var toolbar1: UIToolbar!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var toolbar3: UIToolbar!
    @IBOutlet weak var toolbar2: UIToolbar!
    @IBOutlet weak var attractionstableview: UITableView!
//    {
//        didSet {
//            attractionstableview.dataSource = self
//            attractionstableview.delegate = self
//        }
//    }
    
    struct attractionsCategory
    {
        var categoryId: Int = 0
        var categoryName: String? = nil
        var categoryImage: String? = nil
        var displayid: Int = 0

        
//        init ( categoryId : Int, categoryName: String, categoryImage: UIImage, displayid: Int){
//        self.categoryId = categoryId
//        self.categoryName = categoryName
//        self.categoryImage = categoryImage
//        self.displayid = displayid
//        }
    
    }
   
    var attractions: [attractionsCategory] = []
    
    //var strigarry = ["this", "that"]
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
            view.addSubview(toolbar3)
            view.addSubview(view4)
        
          
            attractionstableview.dataSource = self
            attractionstableview.delegate = self
        
        
        ParseData()
      
            
            let layer = CAGradientLayer()
                   layer.frame = view.bounds
                   layer.colors = [UIColor.white.cgColor, UIColor.link.cgColor]
                   view2.layer.addSublayer(layer)
            
                title = "What To Do"
            }

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
        

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return attractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = attractionstableview.dequeueReusableCell(withIdentifier: "getAttractionsCell", for: indexPath)as!WhatToDoViewTableViewCell
//
        let serverurl=NSURL(string: "https://cert-manager.ntrcsvg.com/tourism/getAttractionCategories.php")
            let imageaddress = attractions[indexPath.row].categoryImage
        let imageURL = NSURL.init(string: imageaddress!, relativeTo: serverurl! as URL)
            cell.imageholder?.sd_setImage(with: imageURL! as URL )
        
        
        //cell.imageholder?.image = attractions[indexPath.row].categoryImage
            cell.titleview?.text = attractions[indexPath.row].categoryName
//
        return cell
    }
    
    

    
    
    func ParseData(){
        
        attractions = []

    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getAttractionCategories.php")
        
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
            let attractionsData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
            print(attractionsData)
            
            for i in 0...attractionsData.count-1{
                let data = attractionsData[i]
                
                var attractionCat = attractionsCategory()
                
                //var getAttraction = data
                attractionCat.categoryId = Int(((data as! NSDictionary)["typeid"] as? String)!)!
                attractionCat.categoryName = (data as! NSDictionary)["sitedescription"] as? String
                attractionCat.categoryImage = (data as! NSDictionary)["image"] as? String
                attractionCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
                
                
                self.attractions.append(attractionCat)
                
                
                
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
                self.attractionstableview.reloadData()
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

