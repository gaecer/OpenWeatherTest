//
//  Config.swift
//  OpenWeatherMap
//
//  Created by Gaetano Cerniglia on 19/06/17.
//  Copyright © 2017 Gaetano Cerniglia. All rights reserved.
//

import Foundation
//STRUCTURE CONTAIN STATIC STRINGS
struct Config {
    //OpenWeather.org API KEY
    public static var apiKey: String { return "794ee299428a7cbde155e5768bf499a5" } // FIXME: -PUT YOUR Openweather.org API Key
    //OpenWeather.org PATH TO GET WEATHER IMAGES
    public static var imageURL: String { return "http://openweathermap.org/img/w/" }
    //WEATHER ICONS
    public static var iconSun: String { return "sunny" }
    public static var iconCloud: String { return "cloudy1" }
    public static var iconRain: String { return "rain" }
    //BACKGROUND IMAGES
    public static var backgroundSun: String { return "sun.jpg" }
    public static var backgroundCloud: String { return "cloud.jpg" }
    public static var backgroundRain: String { return "rain.jpg" }
}
