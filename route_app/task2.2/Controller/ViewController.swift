//
//  ViewController.swift
//  task2.2
//
//  Created by Elizaveta on 5/13/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, UITableViewDataSource, WeatherGetterDelegate {

    @IBOutlet var map: MKMapView!
    @IBOutlet var cityFrom: UITextField!
    @IBOutlet var cityTo: UITextField!
    
    @IBOutlet var findButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var racesLabel: UILabel!
    @IBOutlet var weatherButton: UIButton!
    
    var isCity: Int = 0
    var annotatiionFrom = MKPointAnnotation()
    var annotatiionTo = MKPointAnnotation()
    let locationManager = CLLocationManager()
    var races = [NSManagedObject]()
    var currentRaces = [NSManagedObject]()
    var tapped = 0
    
    var weather: WeatherGetter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        map.addGestureRecognizer(gestureRecognizer)
        cityFrom.delegate = self
        cityTo.delegate = self

        map.showsUserLocation = true
        enableLocationServices()
        escalateLocationServiceAuthorization()
    
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        races = (appDelegate?.getAllRaces())!
        
        tableView.isHidden = true
        racesLabel.isHidden = true
        findButton.sizeToFit()
        
        weather = WeatherGetter(delegate: self)
    }
    
    @IBAction func showRaces(_ sender: Any) {
        tapped += 1
        map.isHidden = !map.isHidden
        cityTo.isHidden = !cityTo.isHidden
        cityFrom.isHidden = !cityFrom.isHidden
        tableView.isHidden = !tableView.isHidden
        racesLabel.isHidden = !racesLabel.isHidden
        weatherButton.isHidden = !weatherButton.isHidden
        if tapped % 2 == 1
        {
            findButton.setTitle("Back", for: UIControl.State.normal)
            findButton.sizeToFit()
            racesLabel.text = "List of trips on the route \"" + cityFrom.text! + " - " + cityTo.text! + "\""
            
            for tRace in races
            {
                let race = tRace as! Record
                if race.cityTo?.elementsEqual(cityTo.text!) == true && race.cityFrom?.elementsEqual(cityFrom.text!) == true
                {
                    currentRaces.append(race)
                }
            }
            tableView.reloadData()
        }
        else
        {
            findButton.setTitle("Trips", for: UIControl.State.normal)
            findButton.sizeToFit()
            currentRaces.removeAll()
        }
    }
    
    @IBAction func showWeather(_ sender: Any) {
        let geocoder = CLGeocoder()
        let city: String
        if isCity == 0
        {
            city = cityFrom.text!
        }
        else
        {
             city = cityTo.text!
        }
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            if error == nil
            {
                if let placemark = placemarks?[0]
                {
                    let location = placemark.location!
                    self.weather.getWeatherByCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                }
            }
        }
    }
    
    
    func didGetWeather(weather: Weather) {
        DispatchQueue.main.async
        {
            var message = "Location: \(weather.city) \nCondition: \(weather.condition)"
            message += "\nTemperature: \(weather.temp) C \nFeels like: \(weather.feelTemp)"
            message += " C \nHumidity \(weather.humidity) % \nPressure: \(weather.pressure) mm"
            let alert = UIAlertController(title: "Weather", message: message, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            self.present(alert, animated: true)
            {
                () -> Void in
            }
        }
    }
    
    func didNotGetWeather(error: Error) {
        DispatchQueue.main.async
        {
            let alert = UIAlertController(title: "Weather", message: "Failed to get weather", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            self.present(alert, animated: true)
            {
                () -> Void in
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return currentRaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let race = currentRaces[indexPath.row] as! Record
        cell.station?.text = race.busStation
        cell.price?.text = (String)(race.price)
        cell.availibilty?.isEnabled = false
        if race.availability == true
        {
            cell.availibilty.setBackgroundImage(UIImage (named: "checked"), for: UIControl.State.normal)
        }
        else
        {
            cell.availibilty.setBackgroundImage(UIImage (named: "unchecked"), for: UIControl.State.normal)
        }
        return cell
    }
    
    func enableLocationServices() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            break
            
        case .authorizedWhenInUse:
            break
            
        case .authorizedAlways:
            break
        }
    }
    
    func escalateLocationServiceAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    @objc func handleLongPressGesture(_ gestureReconizer: UILongPressGestureRecognizer)
    {
        let point = gestureReconizer.location(in: map)
        let coordinate = map.convert(point,toCoordinateFrom: map)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        getPlacemarkFromLocation(location: location, coordinate: coordinate)
    }
    
    
    func getPlacemarkFromLocation(location: CLLocation, coordinate: CLLocationCoordinate2D){
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("Reverse geodcode fail: \(error!.localizedDescription)")
                }
                for placemark in placemarks!
                {
                    if let city =  placemark.locality
                    {
                        self.setAnnotationToMap(type: self.isCity, title: city, coordinate:coordinate)
                    }
                }
        })
    }
    
    func getCoordinate(addressString : String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil
            {
                if let placemark = placemarks?[0]
                {
                    let location = placemark.location!
                    self.setAnnotationToMap(type: self.isCity, title: addressString, coordinate: location.coordinate)
                }
            }
        }
    }
    
    
    func setAnnotationToMap(type: Int, title: String, coordinate: CLLocationCoordinate2D)
    {
        if type == 0
        {
            map.removeAnnotation(annotatiionFrom)
            annotatiionFrom.title = title
            annotatiionFrom.coordinate = coordinate
            map.addAnnotation(annotatiionFrom)
            cityFrom.text = title
        }
        else
        {
            map.removeAnnotation(annotatiionTo)
            annotatiionTo.title = title
            annotatiionTo.coordinate = coordinate
            map.addAnnotation(annotatiionTo)
            cityTo.text = title
        }
    }
    
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == cityFrom
        {
            isCity = 0;
        }
        else if textField == cityTo
        {
            isCity = 1;
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField == cityFrom
        {
            isCity = 0;
        }
        else if textField == cityTo
        {
            isCity = 1;
        }
        getCoordinate(addressString: textField.text!)
    }
   
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}
