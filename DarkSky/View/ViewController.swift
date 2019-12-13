//
//  ViewController.swift
//  DarkSky
//
//  Created by gomathi saminathan on 12/11/19.
//  Copyright © 2019 Rajendran Eshwaran. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var locationManager : CLLocationManager!
    var forecastData = [CurrentWeatherModel]()
    
    var currCityName :String?
    var currWeatherStatus:String?
    var currTemp : Double?
    var currProb: Double?
    var currDate:String?
    var currTime:String?
    
    var weatherModel = [String : CurrentWeatherModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getUserCurrentLocation()
        
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
                                 
                                   self.displayToUI(time: time, date: date, summary: summary, hum: humi, temp: temp, pres: press, icon: icon)
                                    
                            
                                });
                            
                        }
            
                        catch let error as NSError
            
                        {
            
                            print(error);
            
                        }
            
                    }
                
                }.resume()

        }
    
    func displayToUI(time:Double , date:Date , summary:String ,hum:Double , temp:Double , pres:Double , icon:String)
    {
        
        let roundedTemp = Int(temp)
        
        // get the current date and time
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dat = formatter.string(from: currentDateTime)
        
        //get Current Time Format
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm"
        let cTime = formatter1.string(from: currentDateTime)
        

        tempLbl.text = "\(roundedTemp)°"
        dateLbl.text = "Today: \(String(dat))"
        statusLbl.text = summary
        locationLbl.text = "Los Angles"
        timeLbl.text = "TimeNow: \(String(cTime))"
    }
     
}

