//
//  ShopsViewController.swift
//  carneAcme
//
//  Created by Álvaro Martín on 20/12/2016.
//  Copyright © 2016 Álvaro Martín. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacePicker

class ShopsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    var coordenadas = CLLocationCoordinate2D()
    
    let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isMyLocationEnabled = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.myLocationButton = true

        // Pedimos permiso al usuario para usar su localización
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        fetchNearbyPlaces(coordinate: coordenadas)
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
        fetchNearbyPlaces(coordinate: locValue)
    }
    
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        
        mapView.clear()
        
        dataProvider.fetchPlacesNearCoordinate(coordinate: coordinate, radius:searchRadius, types: ["grocery_or_supermarket"]) { places in
            for place: GooglePlace in places {
                let marker = MeatMarker(place: place)
                marker.map = self.mapView
            }
        }
    }
}
