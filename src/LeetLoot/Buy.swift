//
//  Buy.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/27/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Buy: ParentView {
    override func setupView() {
        
    }
}

class Filter: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: .plain)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
