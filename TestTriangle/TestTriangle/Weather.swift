//
//  Weather.swift
//  TestTriangle
//
//  Created by Roman Mykitchak on 15/10/2018.
//  Copyright © 2018 Roman Mykitchak. All rights reserved.
//

import UIKit
import Foundation

class Weather: Codable {
    var cod:String
    var message:Float
    var cnt:Int
    var list:Array = [WeatherDay]()
}
