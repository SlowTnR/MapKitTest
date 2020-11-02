//
//  ViewController.swift
//  MapKitTest
//
//  Created by Ilja Patrushev on 2.11.2020.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let manager: CLLocationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    
    let mapDelta: Double = 0.1


    
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Ready!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        
        label.text = "\(first.coordinate.longitude) | \(first.coordinate.latitude)"
        
        manager.stopUpdatingLocation()
        
        render(first)
    }
    
    func render (_ location: CLLocation){
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: mapDelta, longitudeDelta: mapDelta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    
}

