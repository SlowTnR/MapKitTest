//
//  ViewController.swift
//  MapKitTest
//
//  Created by Ilja Patrushev on 2.11.2020.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController {
    
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var label: UILabel!
    
    let locationManager:CLLocationManager = CLLocationManager()
    let regionInMetters: Double = 10000
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Ready!"
        checkLocationServices()
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMetters, longitudinalMeters: regionInMetters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewUserLocation()
            locationManager.startUpdatingLocation()
            
            break
        case .denied:
            // show alert hot to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show alert with error
            break
        case .authorizedAlways:
            break
        }
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMetters, longitudinalMeters: regionInMetters)
        mapView.setRegion(region, animated: true)
        label.text = "\(location.coordinate.latitude) | \(location.coordinate.longitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

