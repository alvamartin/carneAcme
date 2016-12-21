//
//  MeatMarker.swift
//  carneAcme
//
//  Created by Álvaro Martín on 20/12/2016.
//  Copyright © 2016 Álvaro Martín. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MeatMarker: GMSMarker {
    let place: GooglePlace
    
    init(place: GooglePlace) {
        self.place = place
        super.init()
        
        position = place.coordinate
        icon = UIImage(named:   "pin1")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}

