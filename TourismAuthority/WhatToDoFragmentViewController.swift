//
//  WhatToDoFragmentViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 6/16/22.
//

import UIKit
import SwiftUI
import SDWebImage




class WhatToDoFragmentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var WhatToDoFragmentTitleView: UITextView!
    @IBOutlet weak var imageholder: UIImageView!
    @IBOutlet weak var ContentViewHolder: UIView!
    @IBOutlet weak var BackgroundImageViewHolder: UIView!
    @IBOutlet weak var WhatToDoFragmentBackgroundImage: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        
    ContentViewHolder.layer.cornerRadius = 5.0
    ContentViewHolder.layer.masksToBounds = true
  
        WhatToDoFragmentBackgroundImage.layer.cornerRadius = 5.0
        WhatToDoFragmentBackgroundImage.layer.masksToBounds = true
}
}

class WhatToDoFragmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
 
    
    
    
    var layer:CAGradientLayer!
    @IBOutlet weak var WhatToDoFragmentTableView: UITableView?
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var titleatt: UITextView!

    
    struct WhataToDoList: Codable
    {
        var ListId: Int = 0
        var ListSiteTypeId: Int = 0
        var ListSiteDescription1: String? = nil
        var ListSiteDescription2: String? = nil
        var ListName: String? = nil
        var ListIcon: String? = nil
        var ListBackgroudImage: String? = nil
        var displayid: Int = 0
    }
    var num: Int = 1
    @IBOutlet weak var gradient: UIView!
    var WhatToDoList : [WhataToDoList] = []
 
    @IBOutlet weak var TableViewHolder: UIView!
    @IBOutlet weak var GradientView: UIView!
    
        override func viewDidLoad() {
                super.viewDidLoad()
            view.addSubview(MainView)
            
            WhatToDoFragmentParseData()
                
            WhatToDoFragmentTableView!.dataSource = self
            WhatToDoFragmentTableView!.delegate = self
            
            //titleatt.text = WhataToDoList().ListSiteDescription2
//                let layer = CAGradientLayer()
//                       layer.frame = view.bounds
//                       layer.colors = [UIColor.white.cgColor, UIColor.link.cgColor]
//            GradientView.layer.addSublayer(layer)
//let layer = CAGradientLayer()
            let layer = CAGradientLayer()
                   layer.frame = view.bounds
                   layer.colors = [UIColor.white.cgColor, UIColor.link.cgColor]
                   gradient.layer.addSublayer(layer)
                title = "What To Do"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc1 = storyboard?.instantiateViewController(identifier: "LocationDesc") as? ShareFeatureViewController{
            
//                let serverurl=NSURL(string: "https://cert-manager.ntrcsvg.com/tourism/getTourOperators.php")
//                    let imageaddress = tour[indexPath.row].categoryImage
//                let imageURL = NSURL.init(string: imageaddress!, relativeTo: serverurl! as URL)
//                vc.desimages.sd_setImage(with: imageURL! as URL )
            //vc.nameTitle = accommodation[indexPath.row].categoryName!
            vc1.imageURL = WhatToDoList[indexPath.row].ListBackgroudImage
            vc1.sitedesc = WhatToDoList[indexPath.row].ListSiteDescription2!
            vc1.siteTite = WhatToDoList[indexPath.row].ListName!
//            vc1.phonenumber = accommodation[indexPath.row].categoryNum!
//            vc1.desView = accommodation[indexPath.row].categoryDesc!
            self.navigationController?.pushViewController(vc1, animated: true)
    }
        

}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.WhatToDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WhatToDoFragmentTableView!.dequeueReusableCell(withIdentifier: "WhatToDoFragmentTableViewCell", for: indexPath)as!WhatToDoFragmentTableViewCell
        
        
        //if WhatToDoList[indexPath.row].ListSiteTypeId == 1 {
        
        let serverurl=NSURL(string: "https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
            let imgadd = WhatToDoList[indexPath.row].ListBackgroudImage
        let imageURL = NSURL.init(string: imgadd!, relativeTo: serverurl! as URL)
        cell.WhatToDoFragmentBackgroundImage?.sd_setImage(with: imageURL as? URL, placeholderImage: UIImage(named: "ntrclogofinal.png"))
        
        
        //cell.WhatToDoFragmentBackgroundImage?.image = WhatToDoList[indexPath.row].ListBackgroudImage
            cell.WhatToDoFragmentTitleView?.text = WhatToDoList[indexPath.row].ListName
          
        
//        else {
//            cell.isHidden = true
//        }
        
        
        
        return cell
    }
    

func WhatToDoFragmentParseData(){
    
    //WhatToDoList = []

let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
    
//creating NSMutableURLRequest
let request = NSMutableURLRequest(url: requestURL! as URL)
       
       //setting the method to post
request.httpMethod = "POST"
       
       //creating a task to send the post request
let session = URLSession.shared.dataTask(with: request as URLRequest){
           data, response, error in
           
           //exiting if there is some error
//           if error != nil{
//               print("error is \(String(describing: error))")
//               return;
//           }
           
           //parsing the response
    do {
                   //converting resonse to NSArray
        let data = try? Data(contentsOf: requestURL! as URL)
        let WhatToDoListData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
        print(WhatToDoListData)
        
        for i in 0...WhatToDoListData.count-1{
            let data = WhatToDoListData[i]
            
            var WhatToDoList = WhataToDoList()
            
            //var getAttraction = data
            WhatToDoList.ListSiteDescription1 = (data as! NSDictionary)["sitedescription"] as? String
            WhatToDoList.ListSiteDescription2 = (data as! NSDictionary)["description"] as? String
            WhatToDoList.ListSiteTypeId = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
            WhatToDoList.ListId = Int(((data as! NSDictionary)["siteid"] as? String)!)!
            WhatToDoList.ListName = (data as! NSDictionary)["sitename"] as? String
            WhatToDoList.ListBackgroudImage = (data as! NSDictionary)["image_url"] as? String
            //attractionCat.Listdisplayid = Int(((data as! NSDictionary)["display"] as? String)!)!
            
            
            self.WhatToDoList.append(WhatToDoList)
            
            
            
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
            self.WhatToDoFragmentTableView!.reloadData()
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

