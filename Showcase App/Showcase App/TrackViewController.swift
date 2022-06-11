//
//  TrackViewController.swift
//  Showcase App
//
//  Created by Kukina Anastasia on 23.11.2020.
//

import UIKit
import CoreLocation

class TrackViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationText: UITextView!
    @IBOutlet weak var toggleSwitch: UISwitch!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationText.layer.cornerRadius = 5.0
    }
    
    
    @IBAction func changeToggle(sender: AnyObject) {
        
        if (toggleSwitch.isOn) {
            
            if (!CLLocationManager.locationServicesEnabled()) {
                self.toggleSwitch.isOn = false
            }
            
            if (locationManager == nil) {
                
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.distanceFilter = 10.0
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.startUpdatingLocation()
        } else {
            
            if locationManager != nil {
                locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocation = locations[locations.endIndex-1] as CLLocation
        self.locationText.text = location.description
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        locationText.text = "failed with error \(error.localizedDescription) "
    }
}
