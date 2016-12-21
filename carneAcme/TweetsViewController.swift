//
//  TweetsViewController.swift
//  carneAcme
//
//  Created by Álvaro Martín on 20/12/2016.
//  Copyright © 2016 Álvaro Martín. All rights reserved.
//

import UIKit
import TwitterKit

class TweetsViewController: TWTRTimelineViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        self.dataSource = TWTRSearchTimelineDataSource (searchQuery: "meat is healthy", apiClient: client)

    }
}
