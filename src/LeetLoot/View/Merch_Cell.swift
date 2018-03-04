//
//  d.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Merch_Cell: ParentCell {
    
    internal var items: (summary:itemSummaries?, href:ItemHerf?) {
        didSet {
            if let item = items.summary, let itemHref = items.href {
                configureCellFor(item, itemHref: itemHref)
            } else {
                if let item = items.summary {
                    configureCellFor(item)
                }
            }
        }
    }
    
    let merchImage = { () -> customeImage in
        let image = customeImage()
            image.contentMode = .scaleAspectFit
            image.backgroundColor = .softGrey
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let merchTitle = { () -> UITextView in
        let textView = UITextView()
            textView.isEditable = false
            textView.isSelectable = false
            textView.isScrollEnabled = false
            textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [merchImage, merchTitle])
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    func configureCellFor(_ item: itemSummaries, itemHref: ItemHerf? = nil) {
        merchTitle.attributedFor(item.itemTitle, price: item.fullPrice)
        merchImage.downloadImages(url: item.imgURL)
    }

    private func setupStackView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            merchImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    internal func setupLayoutAttributes() {
        merchImage.layer.borderWidth = 0.5
        merchImage.layer.borderColor = UIColor.softGrey.cgColor
        merchImage.clipsToBounds = true
        merchImage.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        merchTitle.textContainerInset = UIEdgeInsets(top: 5, left: -5, bottom: 0, right: 0)
    }
    
    override func setupView() {
        setupStackView()
        setupLayoutAttributes()
    }
}
