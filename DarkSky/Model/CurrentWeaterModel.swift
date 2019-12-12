//
//  CurrentWeaterModel.swift
//  DarkSky
//
//  Created by gomathi saminathan on 12/12/19.
//  Copyright © 2019 Rajendran Eshwaran. All rights reserved.
//

import Foundation

struct Key {
    static let temprature = "temprature"
    static let precipitationProb = "precipitationProb"
    static let humidity = "humidity"
    static let summary = "summary"
    static let icon = "icon"
}

class CurrentWeatherModel
{
    
    let temprature :Double?
    let precipitationProb :Double?
    let humidity : Double?
    let summary : Double?
    let icon : String?
    
    init?(json: [String : AnyObject]) {
        
        guard let tempraValue = json[Key.temprature],
            let preciValue = json[Key.precipitationProb],
            let humiValue = json[Key.humidity],
            let summValue = json[Key.summary],
            let iconValue = json[Key.icon]
            else {
            return nil
        }
        
        self.temprature = tempraValue as? Double
        self.precipitationProb = preciValue as? Double
        self.humidity = humiValue as? Double
        self.summary = summValue as? Double
        self.icon = iconValue as? String
        
    }
}

