//
//  DayViewController.swift
//  DarkSky
//
//  Created by gomathi saminathan on 12/13/19.
//  Copyright © 2019 Rajendran Eshwaran. All rights reserved.
//

import UIKit
import CoreLocation


class DayViewController: UIViewController  , CLLocationManagerDelegate{

     var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        let userLocation : CLLocation = locations[0] as CLLocation
         print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        let location = CurrentLocationModel.init(lat: (userLocation.coordinate.latitude), long:(userLocation.coordinate.longitude))
                
        fetch(location: location)
    
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error Location Update\(error)")
    }

    func fetch(location:CurrentLocationModel)
    {
        
           let BaseURL  = "https://api.darksky.net/forecast/"
           let APIKey = "8b9d50ba3d44a7d54d8aa6c084e76957/"

        let location = "\(location.latitude),\(location.longtitude)"
            
        let url = URL(string: BaseURL + APIKey + location)
        
        URLSession.shared.dataTask(with:url!)
            {
                (data, _, error) in
        
                if error != nil
                {
                    print(error!);
        
                }
                else
                {
                    do
        
                    {
        
                        let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let currentDatas = parsedData["currently"] as! [String:Any]

                        let time = currentDatas["time"] as! Double

                        let date = Date(timeIntervalSince1970: time);

                        let icon = currentDatas["icon"] as! String;

                        let summary = currentDatas["summary"] as! String;

                        let temp = currentDatas["temperature"] as! Double;

                        let humi = currentDatas["humidity"] as! Double;

                        let press = currentDatas["pressure"] as! Double

                        DispatchQueue.main.async(execute:
                       
                            {
                             
//                               self.displayToUI(time: time, date: date, summary: summary, hum: humi, temp: temp, pres: press, icon: icon)
                                
                        
                            });
                        
                    }
        
                    catch let error as NSError
        
                    {
        
                        print(error);
        
                    }
        
                }
            
            }.resume()

    }
}
