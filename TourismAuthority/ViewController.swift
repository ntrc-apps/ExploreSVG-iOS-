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
import SwiftUI
 
class ViewController: UIViewController{
    
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
    
override func viewDidLoad() {
super.viewDidLoad()
    
 
    let options = MapInitOptions(cameraOptions: CameraOptions(zoom: 11))
    title = "Discover SVG"
    
   
    mapView = MapView(frame: view.bounds,mapInitOptions: options)
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(mapView)
    view.addSubview(toolbar2)
    view.addSubview(toolbar3)

   
    
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
}
