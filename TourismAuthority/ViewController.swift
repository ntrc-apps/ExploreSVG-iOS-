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
 
class ViewController: UIViewController, AnnotationInteractionDelegate{
    
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        
        print("Annotations tapped: \(annotations)")
    }
    
    let satelliteMapStyle = "mapbox://styles/ntrcsvg/cihng4ycb005m92jaeyqwtj87"
     var mapView: MapView!
    internal var cameraLocationConsumer: CameraLocationConsumer!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var leadingC: NSLayoutConstraint!
    @IBOutlet weak var trailingC: NSLayoutConstraint!
    @IBOutlet weak var toolbar1: UIToolbar!
    @IBOutlet weak var toolbar3: UIToolbar!
    @IBOutlet weak var toolbar2: UIToolbar!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var bottomtoolbar: UIToolbar!
    var menuOut = true
    
    struct location {
        var name: String? = nil
        var description: String? = nil
        var id: Int = 0
        var siteType: Int = 0
        var latitude: Double = 0.0
        var longnitude: Double = 0.0
        var image: String? = nil
    }
    
    var locations: [location] = []
    
override func viewDidLoad() {
super.viewDidLoad()
    
 
    let options = MapInitOptions(cameraOptions: CameraOptions(zoom: 11))
    title = "Discover SVG"
    
   
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    // Set the map’s center coordinate and zoom level.
   
    view.addSubview(mapView)
    
    let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
    
    pointAnnotationManager.delegate = self
    
    
    //mapView.st = URL(string: satelliteMapStyle)
   
    
    cameraLocationConsumer = CameraLocationConsumer(mapView: mapView)
    
    mapView.location.options.puckType = .puck2D()

    mapView.mapboxMap.onNext(.mapLoaded) { _ in
    // Register the location consumer with the map
    // Note that the location manager holds weak references to consumers, which should be retained
    self.mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
    }
    
    }
    @IBAction func menuPress(_ sender: Any) {
        print("This is working")
        if (menuOut) {
            
            leadingC.constant = -220
    
        } else
        {
            
            leadingC.constant = 0
            
           
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations:{
            self.view.layoutIfNeeded()})
        
            menuOut = !menuOut
        }

    
    
        
        
    


public class CameraLocationConsumer: LocationConsumer {
weak var mapView: MapView?
 
init(mapView: MapView) {
self.mapView = mapView
    
    
}
    
public func locationUpdate(newLocation: Location) {
    mapView?.mapboxMap.setCamera(
to: CameraOptions(center: newLocation.coordinate))
}
}
    
    func AnnotationsParseData(){
        
        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
        
        locations = []

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
            let locData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
            print(locData)
            
            for i in 0...locData.count-1{
                let data = locData[i]
                
                
var newLocation = location()
                
                newLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
                newLocation.name = (data as! NSDictionary)["sitename"] as? String
                newLocation.description = (data as! NSDictionary)["description"] as? String
                newLocation.latitude = Double(((data as! NSDictionary)["latitude"] as? String)!)!
                newLocation.longnitude = Double(((data as! NSDictionary)["longitude"] as? String)!)!
                newLocation.image = (data as! NSDictionary)["image_url"] as? String
                newLocation.siteType = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
    
                
            }
          

            
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
