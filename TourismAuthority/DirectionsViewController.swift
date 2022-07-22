//
//  DirectionsViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 7/11/22.
//

import Foundation
import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import MapboxMaps
import CoreLocation
import SwiftUI

class DirectionsViewController: UIViewController, CLLocationManagerDelegate {
    
    struct Sites {
        var name: String? = nil
        var sitedescription: String?
        var sitedescription2: String? = ""
        var id: Int? = nil
        var typeID: Int? = nil
        var lat: Double? = nil
        var lng: Double? = nil
        var siteimage: String? = ""
    }
    var sitelocation: [Sites] = []

var navigationMapView: NavigationMapView!
    var mapView: MapView!
var navigationViewController: NavigationViewController?
 
override func viewDidLoad() {
super.viewDidLoad()
 
    //ParsesDirectionsSiteData()
    
    
//    let locationManager = CLLocationManager()
//
//    locationManager.requestAlwaysAuthorization()
//    locationManager.requestLocation()
//
//    if CLLocationManager.locationServicesEnabled() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//    }
//
//     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if let location = locations.first {
//            print(location.coordinate)
//        }
//    }
    
    let origin = CLLocationCoordinate2DMake()
    let destination = CLLocationCoordinate2DMake(13.21553661854771, -61.21577147070738)
    let options = NavigationRouteOptions(coordinates: [origin, destination])

    Directions.shared.calculate(options) { [weak self] (_, result) in
    switch result {
    case .failure(let error):
    print(error.localizedDescription)
    case .success(let response):
    guard let strongSelf = self else {
    return
    }

    // For demonstration purposes, simulate locations if the Simulate Navigation option is on.
    // Since first route is retrieved from response `routeIndex` is set to 0.
    let navigationService = MapboxNavigationService(routeResponse: response, routeIndex: 0, routeOptions: options)
    let navigationOptions = NavigationOptions(navigationService: navigationService)
    let navigationViewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: options, navigationOptions: navigationOptions)
    navigationViewController.modalPresentationStyle = .fullScreen
    // Render part of the route that has been traversed with full transparency, to give the illusion of a disappearing route.
    navigationViewController.routeLineTracksTraversal = true

    strongSelf.present(navigationViewController, animated: true, completion: nil)
    }
    }
}

    

        
   
    
func ParsesDirectionsSiteData(){
   
    
   //switch markerType {
        
    //case AttractionMarkers:
        
        sitelocation = []

let requestURL = NSURL(string:"https://cert-manager.ntrcsvg.com/tourism/getTourismSites.php")
    
//creating NSMutableURLRequest
let request = NSMutableURLRequest(url: requestURL! as URL)
       
       //setting the method to post
request.httpMethod = "POST"
       
       //creating a task to send the post request
    let session = URLSession.shared.dataTask(with: request as URLRequest){ [self]
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
            
            var NewLocation = Sites()
            
            NewLocation.id = Int(((data as! NSDictionary)["siteid"] as? String)!)!
            NewLocation.name = (data as! NSDictionary)["sitename"] as? String
            NewLocation.lat = Double(((data as! NSDictionary)["latitude"] as? String)!)
            NewLocation.lng = Double(((data as! NSDictionary)["longitude"] as? String)!)
            NewLocation.sitedescription = (data as! NSDictionary)["description"] as? String
            NewLocation.typeID = Int(((data as! NSDictionary)["sitetypeid"] as? String)!)!
            NewLocation.sitedescription2 = (data as! NSDictionary)["sitedescription"] as? String
            NewLocation.siteimage = (data as! NSDictionary)["image_url"] as? String
            //tourCat.displayid = Int(((data as! NSDictionary)["display"] as? String)!)!
            
        
            let origin = CLLocationCoordinate2DMake(navigationMapView.mapView.location.latestLocation!.coordinate.latitude,navigationMapView.mapView.location.latestLocation!.coordinate.latitude)
            let destination = CLLocationCoordinate2DMake(NewLocation.lat!, NewLocation.lng!)
            let options = NavigationRouteOptions(coordinates: [origin, destination])
             
            Directions.shared.calculate(options) { [weak self] (_, result) in
            switch result {
            case .failure(let error):
            print(error.localizedDescription)
            case .success(let response):
            guard let strongSelf = self else {
            return
            }
             
            // For demonstration purposes, simulate locations if the Simulate Navigation option is on.
            // Since first route is retrieved from response `routeIndex` is set to 0.
//            let navigationService = MapboxNavigationService(routeResponse: response, routeIndex: 0, routeOptions: options, simulating: simulationIsEnabled ? .always : .onPoorGPS)
//            let navigationOptions = NavigationOptions(navigationService: navigationService)
            let navigationViewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: options)
            navigationViewController.modalPresentationStyle = .fullScreen
            // Render part of the route that has been traversed with full transparency, to give the illusion of a disappearing route.
            navigationViewController.routeLineTracksTraversal = true
             
            strongSelf.present(navigationViewController, animated: true, completion: nil)
            }
            }
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
    session.resume()

}
}

 



