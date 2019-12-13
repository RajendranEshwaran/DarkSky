//
//  MapViewController.swift
//  DarkSky
//
//  Created by gomathi saminathan on 12/13/19.
//  Copyright © 2019 Rajendran Eshwaran. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController , CLLocationManagerDelegate ,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
     var locationManager : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserCurrentLocation()
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
        // Do any additional setup after loading the view.
    }
    
    // Steps : Location manager set for getting user current location
    func getUserCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let userLocation : CLLocation = locations[0] as CLLocation
         print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Location Found"
        annotation.subtitle = "Los Angles"
        mapView.addAnnotation(annotation)
                
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error Location Update\(error)")
    }


}
