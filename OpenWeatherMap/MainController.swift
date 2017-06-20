//
//  MainController.swift
//  OpenWeatherMap
//
//  Created by Gaetano Cerniglia on 19/06/17.
//  Copyright © 2017 Gaetano Cerniglia. All rights reserved.
//

import UIKit
import OpenWeatherSwift
import CoreLocation

class MainController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    
    //dates
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dateLabel1: UILabel!
    @IBOutlet var dateLabel2: UILabel!
    @IBOutlet var dateLabel3: UILabel!
    @IBOutlet var dateLabel4: UILabel!
    @IBOutlet var dateLabel5: UILabel!
    @IBOutlet var dateLabel6: UILabel!
    
    //temperatures
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var temperatureLabel1: UILabel!
    @IBOutlet var temperatureLabel2: UILabel!
    @IBOutlet var temperatureLabel3: UILabel!
    @IBOutlet var temperatureLabel4: UILabel!
    @IBOutlet var temperatureLabel5: UILabel!
    @IBOutlet var temperatureLabel6: UILabel!
    
    //weather icons
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherImage1: UIImageView!
    @IBOutlet var weatherImage2: UIImageView!
    @IBOutlet var weatherImage3: UIImageView!
    @IBOutlet var weatherImage4: UIImageView!
    @IBOutlet var weatherImage5: UIImageView!
    @IBOutlet var weatherImage6: UIImageView!
    
    //Setup WeatherClass with API KEY and format
    private var weatherApi = OpenWeatherSwift(apiKey: Config.apiKey, temperatureFormat: .Celsius)
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation!
    
    //variables to include the outlets into arrays
    private var _dates = [UILabel]()
    private var _temps = [UILabel]()
    private var _weathers = [UIImageView]()
    
    //Set DEFAULT COORDS TO LONDON
    private var lat : Double = 51.509865
    private var long : Double = -0.118092
    
    @IBOutlet var temperaturesSpacing: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign outlets to arrays
        _weathers = [weatherImage, weatherImage1, weatherImage2, weatherImage3, weatherImage4, weatherImage5, weatherImage6]
        _dates = [dateLabel, dateLabel1, dateLabel2, dateLabel3, dateLabel4, dateLabel5, dateLabel6]
        _temps = [temperatureLabel, temperatureLabel1, temperatureLabel2, temperatureLabel3, temperatureLabel4, temperatureLabel5, temperatureLabel6]
     
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //Set and check location
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        //Get current Location
        locationManager.delegate = self //assign delegate to self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer //set accuracy
        locationManager.requestWhenInUseAuthorization() //Request user authorization to use location
        locationManager.startUpdatingLocation() //start monitoring location
        getWeather(lat: lat, long: long) //Get Default weather for London as initial setup
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Receive new location
        let userLocation:CLLocation = locations[0]
        long = userLocation.coordinate.longitude;
        lat = userLocation.coordinate.latitude;
        
        //when user allow the location the coordinates as updated and we can get the current location weather
        getWeather(lat: lat,long: long)

        locationManager.stopUpdatingLocation() //Stop monitoring location, just one coordinate needed
    }
    
    func setImg(icon: String, i: Int) {
        //Setting weather 
        //Get local image if mapped or remote Openweather images with async queue
        
        switch icon {
        case "04d", "02d": //cloud
            self._weathers[i].image = UIImage.gifImageWithName(name: Config.iconCloud)
        case "01d", "02n": //clear
            self._weathers[i].image = UIImage.gifImageWithName(name: Config.iconSun)
        case "10d": //rain
            self._weathers[i].image = UIImage.gifImageWithName(name: Config.iconRain)
            
        default:
            //GET DEFAULT OPENWEATHER IMAGES
            let url = URL(string:  Config.imageURL + icon + ".png") //with the icon name we can get the images from openweathermap
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self._weathers[i].image = UIImage(data: data!)
                }
            }
        }
        
    }
    
    func setDays(date: Date, i: Int) -> String {
        // Accepts an Int value (the index) and a Date value
        // Returns: two date format of the string
        // "Today, d MMM yyyy",  if index is 0
        // "E", if index is != 0
        
        let dateFormatter = DateFormatter()
        var dateString=""
        if (i==0){
            dateFormatter.dateFormat = "d MMM yyyy"
            dateString = "Today, " + dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "E"
            dateString = dateFormatter.string(from: date)
        }
        return dateString
    }
    
    func setTemps(tempMin: Double, tempMax: Double) -> String {
        // Accepts two double values which are minimum and maximum temperatures
        // Returns: the two values formatted as nn° - nn°
        return String(format:"%.0f", tempMin) + "° - " + String(format:"%.0f", tempMax) + "°"
    }
    
    func setBackgroundImage(icon: String) -> UIImage {
        var image : UIImage
        switch icon {
        case "04d", "02d": //cloud
            image = UIImage(named: Config.backgroundCloud)!
        case "01d", "02n": //clear
            image = UIImage(named: Config.backgroundSun)!
        case "10d": //rain
            image = UIImage(named: Config.backgroundRain)!
        default:
            //GET DEFAULT OPENWEATHER IMAGES
            image = UIImage(named: Config.backgroundSun)!
        }
        return image
    }
    
    func getWeather(lat:Double, long: Double) {
        //Get weather from server, and receive an object with unwrapped values from the original json
        _ = weatherApi.forecastWeatherByCoordinates(coords: CLLocationCoordinate2DMake(lat, long), type: ForecastType.Daily) {
            (results) in let ret = Forecast(data: results, type: ForecastType.Daily)
            //Assign weather values to the view
            var i = 0
            for icon in ret.icon {
             //iterate the 7 values
             //DAY
             self._dates[i].text = self.setDays(date: ret.dates[i], i: i)
                
             //Temperature
              self._temps[i].text = self.setTemps(tempMin: ret.tempMin[i],  tempMax: ret.tempMax[i])
                
             //Location
             self.locationLabel.text = ret.city + ", " + ret.country
            
             //Icon Image
             self.setImg(icon: icon, i: i)

             if (i==0){
              //Set background Image, just once for the current day with i=0
              self.backgroundImage.image = self.setBackgroundImage(icon: icon)
             }
   
             i+=1
            }
        
        }
        
    }
   
}
