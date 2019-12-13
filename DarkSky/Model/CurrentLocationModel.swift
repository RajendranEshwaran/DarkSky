//
//  CurrentLocationModel.swift
//  DarkSky
//
//  Created by gomathi saminathan on 12/12/19.
//  Copyright © 2019 Rajendran Eshwaran. All rights reserved.
//

import Foundation

class CurrentLocationModel{
    
    var latitude : Double = 0.0
    var longtitude : Double = 0.0

    
    init(lat:Double , long:Double) {
        self.latitude = lat
        self.longtitude = long
    }
}


