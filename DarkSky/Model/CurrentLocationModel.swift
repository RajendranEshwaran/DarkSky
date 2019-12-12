//
//  CurrentLocationModel.swift
//  DarkSky
//
//  Created by gomathi saminathan on 12/12/19.
//  Copyright © 2019 Rajendran Eshwaran. All rights reserved.
//

import Foundation

class CurrentLocationModel{
    
    let latitude : Double = 0.0
    let longtitude : Double = 0.0

}

extension CurrentLocationModel : CustomStringConvertible {
    var description : String{
        return "\(String(describing: latitude)),\(String(describing: longtitude))"
    }
}
