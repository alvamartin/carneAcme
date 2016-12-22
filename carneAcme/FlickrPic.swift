//
//  FlickrPic.swift
//  carneAcme
//
//  Created by Álvaro Martín on 22/12/2016.
//  Copyright © 2016 Álvaro Martín. All rights reserved.
//

import UIKit

class FlickrPic: NSObject {

    let id: String
    let farm: String
    let server: String
    let secret: String
    
    init(id: String, farm: String, server: String, secret: String) {
        self.id = id
        self.farm = farm
        self.server = server
        self.secret = secret
        super.init()
    }
}
