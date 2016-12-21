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
    let searchRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordenadas.latitude = 28.466667
        coordenadas.longitude = -16.25
        let camera = GMSCameraPosition.camera(withLatitude: coordenadas.latitude, longitude: coordenadas.longitude, zoom: 15)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        

        // Pedimos permiso al usuario para usar su localización
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        fetchNearbyPlaces(coordinate: coordenadas)
        
       // self.view = mapView

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        coordenadas = locValue
        //mapView.camera = GMSCameraPosition(target: locValue, zoom: 10, bearing: 0, viewingAngle: 0)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
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
