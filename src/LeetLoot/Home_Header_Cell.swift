//
//  Home_Header_Cell.swift
//  LeetLoot
//
//  Created by Will on 1/18/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class Home_Header_Cell: ParentCell {

    let title = { () -> UILabel in
        let label = UILabel()
            label.textColor = .black
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 15)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        backgroundColor = .customGray
        setupHeaderTitlle()
    }
    
    private func setupHeaderTitlle() {
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
