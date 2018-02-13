//
//  Twitter_Timeline.swift
//  LeetLoot
//
//  Created by Will on 2/12/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: TWTRTimelineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = TWTRUserTimelineDataSource(screenName: "blizzard_ent", apiClient: TWTRAPIClient())
    }
}
