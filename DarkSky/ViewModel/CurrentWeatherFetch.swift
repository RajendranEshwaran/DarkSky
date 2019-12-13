//
//  WeatherData.swift
//  WeatherCast
//
//  Created by Rajendran Eshwaran on 12/2/19.
//  Copyright © 2019 Rajendran Eshwaran. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentWeatherFetch{
    //https://api.darksky.net/forecast/8b9d50ba3d44a7d54d8aa6c084e76957/37.785834,-122.406417
    
   
    
    /*func getWeather(location:CurrentLocationModel ) {
        
        // This is a pretty simple networking task, so the shared session will do.
    let session = URLSession.shared
    let location = "\(location.latitude),\(location.longtitude)"
      
        guard let url = URL(string: BaseURL + APIKey + location) else { return }
        
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in

             var information: CurrentWeatherModel
            
            if let error = error {
              // Case 1: Error
              // We got some kind of error while trying to get data from the server.
              print("Error:\n\(error)")
            }
            else {
              // Case 2: Success
              // We got a response from the server!
              print("Raw data:\n\(data!)\n")
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
              print("Human-readable data:\n\(dataString!)")
               
                information.temprature = dataString
            }
        }
        task.resume()
        }*/
    
    
    static func fetch(location:CurrentLocationModel, completion: @escaping ([String: CurrentWeatherModel]) -> Void)
    {
        
           let BaseURL  = "https://api.darksky.net/forecast/"
           let APIKey = "8b9d50ba3d44a7d54d8aa6c084e76957/"
           let currentweather = [String: CurrentWeatherModel]();

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
        
                        let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any];
        
                        let dailyConditions = parsedData["daily"] as! [String:AnyObject];
        
                        let daysData = dailyConditions["data"] as! [AnyObject];
        
                        for case let dayData in daysData
        
                        {
        
                            let time = dayData["time"] as! Double;
        
                            let date = Date(timeIntervalSince1970: time);
        
                            let icon = dayData["icon"] as! String;
        
                            let summary = dayData["summary"] as! String;
        
                            let tempMin = dayData["temperatureMin"] as! Double;
        
                            let tempMax = dayData["temperatureMax"] as! Double;
        
//                            currentweather[date.dateOnlyString()] = currentweather(date:date, icon:icon, summary: summary, tempMin: tempMin, tempMax:tempMax);
//
                            print("\(time) \(date) \(summary) \(tempMax) \(tempMin)")
                        }
        
                    }
        
                    catch let error as NSError
        
                    {
        
                        print(error);
        
                    }
        
                }
    
                completion(currentweather);
        
            }.resume()

    }
    
    }
