# OpenWeatherTest
Weather forecast test project, based on openweathermap.org API

To install the dependencies run `pod install` to the rood directory

(
 if you don't have CocoaPods installed, this is the right moment, run:
  $ [sudo] gem install cocoapods

 or if you need to update CocoaPods, run:
  $ [sudo] gem install cocoapods
)

**Usage:**
Go to Config.swift and put you OpenWeather API KEY

**General Information:**
The app shows the OpenWeatherMap 5 day weather forecast (using the API on http://openweathermap.org/forecast5).

The project is in swift3

- Temperature Format
  - Celsius

- Default Location
  - London

When the app start the user is notified about the app is going to detect the GPS position, if user allow the detection the app get the weather forecast of the user's position, otherwise it shows the London weather forecast.

**Unit Test:**
Inside the project you can find MainControllerTests class on where you can find a couple of unit test to run (testSetDays, testSetTemps).
I didn't make any test on imported library.

**Future Implementations:**
These are all the points I would like to upgrade in the future:

- Functional
  - Day forecast detail: clicking on a single day, the app will show a modal view with all details of the weather forecast for that day
  - Give to the user the possibility to change the city, the temperature format
  - Show 16 day / daily forecast and Historical data
    - Improve the app structure to be more flexible, with a UICollectionViewController
  - Connect to some live cam to show the live weather conditions
  - Allow user to share a picture with stamped above the current weather conditions
  - The app will require more Unit Test, and when the UI will be improved I'll provide also UI Test

**External resources notes:**
The app require OpenWeatherSwift pod, I did a fork of this library because the parser was not aligned to the current version of OpenWeatherMap API.
OpenWeatherSwift has two pods dependencies: Alamofire and SwiftyJSON, to manage the remote API calls and to parse the JSON datas easily.

**Author:**
{
"name":"Gaetano Cerniglia",
"email":"cernigliagaetano@gmail.com",
"skype":"gaetano.cerniglia",
"linkedin":"https://www.linkedin.com/in/gaetano-cerniglia-a8491928/"
}
