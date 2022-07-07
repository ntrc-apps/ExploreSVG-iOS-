//
//  ViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 4/14/22.
//

import UIKit
import MapboxMaps
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation
import MapboxNavigationNative
import SwiftUI
 

class ViewController: UIViewController, AnnotationInteractionDelegate {
    
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
       //let sitedesc2 = view.annotation?.sitedescription
//        print("Annotations tapped")
        
        if let vc2 = storyboard?.instantiateViewController(identifier: "LocationDesc") as? ShareFeatureViewController{
//
//            //vc2.sitedesc = sitedescription!
//        //vc2.phonenumber = accommodation[indexPath.row].categoryNum!
            self.navigationController?.pushViewController(vc2, animated: true)
    }
    }
    
    let AttractionMarkers = "Attraction Markers"
    let BeachMarkers = "Beach Markers"
    let ParkMarkers = "Park Markers"
    let DivingMarkers = "Diving Markers"
    let EcoMarkers = "Eco Markers"
    let WaterfallMarkers = "Waterfall Markers"
    let SpringMarkers = "Spring Markers"
    let AccommodationMarkers = "Accommodation Markers"
    
    
    class Sites {
        var name: String? = nil
        var sitedescription: String? = nil
        var sitedescription2: String? = nil
        var id: Int? = nil
        var typeID: Int? = nil
        var lat: Double? = nil
        var lng: Double? = nil
        var image: String? = nil
    }
    
    var sitelocation: [Sites] = []
internal var mapView: MapView!
internal var cameraLocationConsumer: CameraLocationConsumer!
internal let toggleBearingImageButton: UIButton = UIButton(frame: .zero)
internal var showsBearingImage: Bool = false {
didSet {
syncPuckAndButton()
}
}
override public func viewDidLoad() {
super.viewDidLoad()
    
    ParseSiteData("")
 
// Set initial camera settings
let options = MapInitOptions(cameraOptions: CameraOptions(zoom: 15.0))
 
mapView = MapView(frame: view.bounds, mapInitOptions: options)
mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.addSubview(mapView)
    
    //let ann = mapView.annotations.makePointAnnotationManager()

            // Make self the `AnnotationInteractionDelegate` to get called back on tap events
    
 
// Setup and create button for toggling show bearing image
setupToggleShowBearingImageButton()
 
cameraLocationConsumer = CameraLocationConsumer(mapView: mapView)
 
// Add user position icon to the map with location indicator layer
mapView.location.options.puckType = .puck2D()
 
// Allows the delegate to receive information about map events.
mapView.mapboxMap.onNext(.mapLoaded) { _ in
// Register the location consumer with the map
// Note that the location manager holds weak references to consumers, which should be retained
self.mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
 
// Needed for internal testing purposes.
}
}
 
@objc func showHideBearingImage() {
showsBearingImage.toggle()
}
 
func syncPuckAndButton() {
// Update puck config
let configuration = Puck2DConfiguration.makeDefault(showBearing: showsBearingImage)
 
mapView.location.options.puckType = .puck2D(configuration)
 
// Update button title
let title: String = showsBearingImage ? "Hide bearing image" : "Show bearing image"
toggleBearingImageButton.setTitle(title, for: .normal)
}
 
private func setupToggleShowBearingImageButton() {
// Styling
toggleBearingImageButton.backgroundColor = .systemBlue
toggleBearingImageButton.addTarget(self, action: #selector(showHideBearingImage), for: .touchUpInside)
toggleBearingImageButton.setTitleColor(.white, for: .normal)
syncPuckAndButton()
toggleBearingImageButton.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(toggleBearingImageButton)
 
// Constraints
toggleBearingImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
toggleBearingImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
toggleBearingImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0).isActive = true
    
}

 


    
    func ParseSiteData(_ markerType: String){
       
        
       //switch markerType {
            
        //case AttractionMarkers:
            
            sitelocation = []

    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
        
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
            let siteData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
            print(siteData)
            
            for i in 0...siteData.count-1{
                let data = siteData[i]
                
                let NewLocation = Sites()
                
                NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
                NewLocation.name = (data as! NSDictionary)["sitename"] as? String
                NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
                NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
                NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
                NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
                NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
                NewLocation.image = (data as! NSDictionary)["image_url"] as? String
                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
                
                let lineCoordinates = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
                let ann = self.mapView.annotations.makePointAnnotationManager()
                ann.delegate = self
                var customPointAnnotation = PointAnnotation(coordinate: lineCoordinates)
                customPointAnnotation.image = .init(image: UIImage(named: "whattodoicon")!, name: "whattodoicon")
                ann.annotations = [customPointAnnotation]
//                let annotations = Point(CLLocationCoordinate2D(latitude: NewLocation.lat!, longitude: NewLocation.lng!))
//                mapView.annotations(annotations)
//                self.sitelocation.append(NewLocation)
            }
        }
    
            
        catch{
                do {
                   print("error 2")
               }
           }
           //executing the task
    
    }
            
//        case BeachMarkers:
//
//            sitelocation = []
//
//    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
//
//    //creating NSMutableURLRequest
//    let request = NSMutableURLRequest(url: requestURL! as URL)
//
//           //setting the method to post
//    request.httpMethod = "POST"
//
//           //creating a task to send the post request
//    let session = URLSession.shared.dataTask(with: request as URLRequest){
//               data, response, error in
//
//               //exiting if there is some error
//               if error != nil{
//                   print("error is \(String(describing: error))")
//                   return;
//               }
//
//               //parsing the response
//        do {
//                       //converting resonse to NSArray
//            let data = try? Data(contentsOf: requestURL! as URL)
//            let siteData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
//            print(siteData)
//
//            for i in 0...siteData.count-1{
//                let data = siteData[i]
//
//                let NewLocation = Sites()
//
//                NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
//                NewLocation.name = (data as! NSDictionary)["sitename"] as? String
//                NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
//                NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
//                NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
//                NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
//                NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
//                NewLocation.image = (data as! NSDictionary)["image_url"] as? String
//                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
//
//                let lineCoordinates = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
//                let ann = self.mapView.annotations.makePointAnnotationManager()
//                var customPointAnnotation = PointAnnotation(coordinate: lineCoordinates )
//                customPointAnnotation.image = .init(image: UIImage(named: "whattodoicon")!, name: "whattodoicon")
//                ann.annotations = [customPointAnnotation]
////                let annotations = Point(CLLocationCoordinate2D(latitude: NewLocation.lat!, longitude: NewLocation.lng!))
////                mapView.annotations(annotations)
////                self.sitelocation.append(NewLocation)
//            }
//        }
//
//
//        catch{
//                do {
//                   print("error 2")
//               }
//           }
//           //executing the task
//
//    }
//
//        case ParkMarkers:
//
//            sitelocation = []
//
//    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
//
//    //creating NSMutableURLRequest
//    let request = NSMutableURLRequest(url: requestURL! as URL)
//
//           //setting the method to post
//    request.httpMethod = "POST"
//
//           //creating a task to send the post request
//    let session = URLSession.shared.dataTask(with: request as URLRequest){
//               data, response, error in
//
//               //exiting if there is some error
//               if error != nil{
//                   print("error is \(String(describing: error))")
//                   return;
//               }
//
//               //parsing the response
//        do {
//                       //converting resonse to NSArray
//            let data = try? Data(contentsOf: requestURL! as URL)
//            let siteData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
//            print(siteData)
//
//            for i in 0...siteData.count-1{
//                let data = siteData[i]
//
//                let NewLocation = Sites()
//
//                NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
//                NewLocation.name = (data as! NSDictionary)["sitename"] as? String
//                NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
//                NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
//                NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
//                NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
//                NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
//                NewLocation.image = (data as! NSDictionary)["image_url"] as? String
//                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
//
//                let lineCoordinates = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
//                let ann = self.mapView.annotations.makePointAnnotationManager()
//                var customPointAnnotation = PointAnnotation(coordinate: lineCoordinates )
//                customPointAnnotation.image = .init(image: UIImage(named: "whattodoicon")!, name: "whattodoicon")
//                ann.annotations = [customPointAnnotation]
////                let annotations = Point(CLLocationCoordinate2D(latitude: NewLocation.lat!, longitude: NewLocation.lng!))
////                mapView.annotations(annotations)
////                self.sitelocation.append(NewLocation)
//            }
//        }
//
//
//        catch{
//                do {
//                   print("error 2")
//               }
//           }
//           //executing the task
//
//    }
//
//        case DivingMarkers:
//
//            sitelocation = []
//
//    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
//
//    //creating NSMutableURLRequest
//    let request = NSMutableURLRequest(url: requestURL! as URL)
//
//           //setting the method to post
//    request.httpMethod = "POST"
//
//           //creating a task to send the post request
//    let session = URLSession.shared.dataTask(with: request as URLRequest){
//               data, response, error in
//
//               //exiting if there is some error
//               if error != nil{
//                   print("error is \(String(describing: error))")
//                   return;
//               }
//
//               //parsing the response
//        do {
//                       //converting resonse to NSArray
//            let data = try? Data(contentsOf: requestURL! as URL)
//            let siteData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
//            print(siteData)
//
//            for i in 0...siteData.count-1{
//                let data = siteData[i]
//
//                let NewLocation = Sites()
//
//                NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
//                NewLocation.name = (data as! NSDictionary)["sitename"] as? String
//                NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
//                NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
//                NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
//                NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
//                NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
//                NewLocation.image = (data as! NSDictionary)["image_url"] as? String
//                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
//
//                let lineCoordinates = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
//                let ann = self.mapView.annotations.makePointAnnotationManager()
//                var customPointAnnotation = PointAnnotation(coordinate: lineCoordinates )
//                customPointAnnotation.image = .init(image: UIImage(named: "whattodoicon")!, name: "whattodoicon")
//                ann.annotations = [customPointAnnotation]
////                let annotations = Point(CLLocationCoordinate2D(latitude: NewLocation.lat!, longitude: NewLocation.lng!))
////                mapView.annotations(annotations)
////                self.sitelocation.append(NewLocation)
//            }
//        }
//
//
//        catch{
//                do {
//                   print("error 2")
//               }
//           }
//           //executing the task
//
//    }
//
//        case EcoMarkers:
//
//            sitelocation = []
//
//    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
//
//    //creating NSMutableURLRequest
//    let request = NSMutableURLRequest(url: requestURL! as URL)
//
//           //setting the method to post
//    request.httpMethod = "POST"
//
//           //creating a task to send the post request
//    let session = URLSession.shared.dataTask(with: request as URLRequest){
//               data, response, error in
//
//               //exiting if there is some error
//               if error != nil{
//                   print("error is \(String(describing: error))")
//                   return;
//               }
//
//               //parsing the response
//        do {
//                       //converting resonse to NSArray
//            let data = try? Data(contentsOf: requestURL! as URL)
//            let siteData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
//            print(siteData)
//
//            for i in 0...siteData.count-1{
//                let data = siteData[i]
//
//                let NewLocation = Sites()
//
//                NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
//                NewLocation.name = (data as! NSDictionary)["sitename"] as? String
//                NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
//                NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
//                NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
//                NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
//                NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
//                NewLocation.image = (data as! NSDictionary)["image_url"] as? String
//                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
//
//                let lineCoordinates = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
//                let ann = self.mapView.annotations.makePointAnnotationManager()
//                var customPointAnnotation = PointAnnotation(coordinate: lineCoordinates )
//                customPointAnnotation.image = .init(image: UIImage(named: "whattodoicon")!, name: "whattodoicon")
//                ann.annotations = [customPointAnnotation]
////                let annotations = Point(CLLocationCoordinate2D(latitude: NewLocation.lat!, longitude: NewLocation.lng!))
////                mapView.annotations(annotations)
////                self.sitelocation.append(NewLocation)
//            }
//        }
//
//
//        catch{
//                do {
//                   print("error 2")
//               }
//           }
//           //executing the task
//
//    }
//
//        case WaterfallMarkers:
//
//            sitelocation = []
//
//    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
//
//    //creating NSMutableURLRequest
//    let request = NSMutableURLRequest(url: requestURL! as URL)
//
//           //setting the method to post
//    request.httpMethod = "POST"
//
//           //creating a task to send the post request
//    let session = URLSession.shared.dataTask(with: request as URLRequest){
//               data, response, error in
//
//               //exiting if there is some error
//               if error != nil{
//                   print("error is \(String(describing: error))")
//                   return;
//               }
//
//               //parsing the response
//        do {
//                       //converting resonse to NSArray
//            let data = try? Data(contentsOf: requestURL! as URL)
//            let siteData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
//            print(siteData)
//
//            for i in 0...siteData.count-1{
//                let data = siteData[i]
//
//                let NewLocation = Sites()
//
//                NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
//                NewLocation.name = (data as! NSDictionary)["sitename"] as? String
//                NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
//                NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
//                NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
//                NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
//                NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
//                NewLocation.image = (data as! NSDictionary)["image_url"] as? String
//                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
//
//                let lineCoordinates = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
//                let ann = self.mapView.annotations.makePointAnnotationManager()
//                var customPointAnnotation = PointAnnotation(coordinate: lineCoordinates )
//                customPointAnnotation.image = .init(image: UIImage(named: "whattodoicon")!, name: "whattodoicon")
//                ann.annotations = [customPointAnnotation]
////                let annotations = Point(CLLocationCoordinate2D(latitude: NewLocation.lat!, longitude: NewLocation.lng!))
////                mapView.annotations(annotations)
////                self.sitelocation.append(NewLocation)
//            }
//        }
//
//
//        catch{
//                do {
//                   print("error 2")
//               }
//           }
//           //executing the task
//
//    }
//        case SpringMarkers:
//
//            sitelocation = []
//
//    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
//
//    //creating NSMutableURLRequest
//    let request = NSMutableURLRequest(url: requestURL! as URL)
//
//           //setting the method to post
//    request.httpMethod = "POST"
//
//           //creating a task to send the post request
//    let session = URLSession.shared.dataTask(with: request as URLRequest){
//               data, response, error in
//
//               //exiting if there is some error
//               if error != nil{
//                   print("error is \(String(describing: error))")
//                   return;
//               }
//
//               //parsing the response
//        do {
//                       //converting resonse to NSArray
//            let data = try? Data(contentsOf: requestURL! as URL)
//            let siteData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
//            print(siteData)
//
//            for i in 0...siteData.count-1{
//                let data = siteData[i]
//
//                let NewLocation = Sites()
//
//                NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
//                NewLocation.name = (data as! NSDictionary)["sitename"] as? String
//                NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
//                NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
//                NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
//                NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
//                NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
//                NewLocation.image = (data as! NSDictionary)["image_url"] as? String
//                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
//
//                let lineCoordinates = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
//                let ann = self.mapView.annotations.makePointAnnotationManager()
//                var customPointAnnotation = PointAnnotation(coordinate: lineCoordinates )
//                customPointAnnotation.image = .init(image: UIImage(named: "whattodoicon")!, name: "whattodoicon")
//                ann.annotations = [customPointAnnotation]
////                let annotations = Point(CLLocationCoordinate2D(latitude: NewLocation.lat!, longitude: NewLocation.lng!))
////                mapView.annotations(annotations)
////                self.sitelocation.append(NewLocation)
//            }
//        }
//
//
//        catch{
//                do {
//                   print("error 2")
//               }
//           }
//           //executing the task
//
//    }
//        case AccommodationMarkers:
//
//            sitelocation = []
//
//    let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
//
//    //creating NSMutableURLRequest
//    let request = NSMutableURLRequest(url: requestURL! as URL)
//
//           //setting the method to post
//    request.httpMethod = "POST"
//
//           //creating a task to send the post request
//    let session = URLSession.shared.dataTask(with: request as URLRequest){
//               data, response, error in
//
//               //exiting if there is some error
//               if error != nil{
//                   print("error is \(String(describing: error))")
//                   return;
//               }
//
//               //parsing the response
//        do {
//                       //converting resonse to NSArray
//            let data = try? Data(contentsOf: requestURL! as URL)
//            let siteData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
//            print(siteData)
//
//            for i in 0...siteData.count-1{
//                let data = siteData[i]
//
//                let NewLocation = Sites()
//
//                NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
//                NewLocation.name = (data as! NSDictionary)["sitename"] as? String
//                NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
//                NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
//                NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
//                NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
//                NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
//                NewLocation.image = (data as! NSDictionary)["image_url"] as? String
//                //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
//
//                let lineCoordinates = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
//                let ann = self.mapView.annotations.makePointAnnotationManager()
//                var customPointAnnotation = PointAnnotation(coordinate: lineCoordinates )
//                customPointAnnotation.image = .init(image: UIImage(named: "whattodoicon")!, name: "whattodoicon")
//                ann.annotations = [customPointAnnotation]
////                let annotations = Point(CLLocationCoordinate2D(latitude: NewLocation.lat!, longitude: NewLocation.lng!))
////                mapView.annotations(annotations)
////                self.sitelocation.append(NewLocation)
//            }
//        }
//
//
//        catch{
//                do {
//                   print("error 2")
//               }
//           }
//           //executing the task
//
    
            
    session.resume()
      
        }
        
        
    }
    
  
    




// Create class which conforms to LocationConsumer, update the camera's centerCoordinate when a locationUpdate is received
public class CameraLocationConsumer: LocationConsumer {
weak var mapView: MapView?
 
init(mapView: MapView) {
self.mapView = mapView
}
 
public func locationUpdate(newLocation: Location) {
mapView?.camera.ease(
to: CameraOptions(center: newLocation.coordinate, zoom: 10),
duration: 1.3)
}
}
