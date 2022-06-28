//
//  AboutUsViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/5/22.
//

import UIKit
import SwiftUI



class TaxiFragmentViewController: UIViewController {
    
    
    @IBOutlet weak var OpImage: UIImageView!
    @IBOutlet weak var TitleHolder: UIView!
    
        
//        TitleHolder.layer.cornerRadius = 5.0
//        TitleHolder.layer.masksToBounds = true
    struct TaxiOperator
        {
            var OperatorId: Int = 0
            var OperatorName: String? = nil
            var OperatorImage: String? = nil
            var OperatorNumber: String? = nil
        }

    var TaxiOperators: [TaxiOperator] = []
    
    @IBOutlet weak var WebTItle: UITextView!
    @IBOutlet weak var PhoneTitle: UITextView!
    @IBOutlet weak var MainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(MainView)
       
//        TitleHolder.layer.cornerRadius = 5.0
//        TitleHolder.layer.masksToBounds = true
//
        TaxiFragmentParseData()
//
//        TaxiFragmentTableView.dataSource = self
//        TaxiFragmentTableView.delegate = self
//
        title = "Taxi Operator"
    }
   
    func TaxiFragmentParseData(){
        
        TaxiOperators = []

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
            let TaxiOperatorData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
            print(TaxiOperatorData)
            
            for i in 0...TaxiOperatorData.count-1{
                let data = TaxiOperatorData[i]
                
                var TaxiOperators = TaxiOperator()
                
                //var getAttraction = data
                TaxiOperators.OperatorName = (data as! NSDictionary)["taxi_name"] as? String
                TaxiOperators.OperatorId = Int(((data as! NSDictionary)["taxi_id"] as? String)!)!
                //WhatToDoList.ListId = Int(((data as! NSDictionary)["typeid"] as? String)!)!
                TaxiOperators.OperatorNumber = (data as! NSDictionary)["taxi_number"] as? String
                TaxiOperators.OperatorImage = (data as! NSDictionary)["image_url"] as? String
                //attractionCat.Listdisplayid = Int(((data as! NSDictionary)["display"] as? String)!)!
                
                
                self.TaxiOperators.append(TaxiOperators)
                
                
            
    //                let eachAttraction = data as! NSDictionary [String: Any]
    //                let categoryId = eachAttraction["typeid"] as! Int
    //                let categoryName = eachAttraction["sitedescription"] as? String
    //                let categoryImage = UIImage(contentsOfFile: eachAttraction["image"] as! String)
    //                let displayid = eachAttraction["display"] as! Int
    //
    //                self.attractions.append(attractionsCategory(categoryId: categoryId, categoryName: categoryName!, categoryImage: categoryImage!, displayid: displayid))
    //
                
            }
         }
    }
        ///DispatchQueue.main.async {
//                self.MainView.reloadData()
//            }
//
//    //            for i in 0...locResponse.count-1 {
//    //                let data = locResponse[i]
//    //
//    //                //var attractionsCategory = attractionsCategory(categoryId: Int, categoryName: String, categoryImage: String, displayid: Int)
//    ////                attractionsCategory.categoryId = (data as! NSDictionary)["typeid"] as? Int
//    ////                attractionsCategory.categoryName = (data as! NSDictionary)["sitedescription"] as? String
//    ////                attractionsCategory.categoryImage = (data as! NSDictionary)["image"] as? String
//
//
//
//            }
//        catch{
//                do {
//                   print("error 2")
//               }
//           }
//           //executing the task
//
//    }
    session.resume()
        }
    }

  

