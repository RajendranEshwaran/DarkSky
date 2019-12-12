//
//  WeatherData.swift
//  WeatherCast
//
//  Created by Rajendran Eshwaran on 12/2/19.
//  Copyright © 2019 Rajendran Eshwaran. All rights reserved.
//

import Foundation
import CoreLocation

struct CurrentWeatherFetch{
    
    let summary:String
    let icon:String
    let temprature:Double
    
    
    enum SerializationError:Error{
        case missing(String)
        case invalid(String,Any)
        
    }
    
    init(json:[String:Any]) throws {
        
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let temperature = json["temperatureMax"] as? Double else {throw SerializationError.missing("temp is missing")}
        
        self.summary = summary
        self.icon = icon
        self.temprature = temperature
    }
    
    static let basePath = "https://api.darksky.net/forecast/8b9d50ba3d44a7d54d8aa6c084e76957/"

    
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([CurrentWeatherFetch]?) -> ()) {
        
        let url = basePath + "\(location.latitude),\(location.longitude)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[CurrentWeatherFetch] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["currently"] as? [String:Any] {
                            
                            if let weatherObject = try? CurrentWeatherFetch(json: dailyForecasts) {
                                forecastArray.append(weatherObject)
                            }
                            
                           /* if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? CurrentWeatherFetch(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }*/
                        }
                    
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
                
            }
            
            
        }
        
        task.resume()
    
    }
}
