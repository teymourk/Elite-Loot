//
//  Merchendise.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/11/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

//Root of the API Call
struct Root:Codable, BrowseAPI {    
    typealias Model = Root
    
    var total: Int?,
        itemHref: ItemHerf?,
        itemSummaries: [itemSummaries]?,
        keyWord: String?,
        filterBy: Filters.option?,
        sortBy: Sort.option?,
        fetchLimit: Int?
    
    init(queryKey: String, filterBy: Filters.option, sortBy: Sort.option, limit: Int? = nil) {
        self.keyWord = queryKey
        self.filterBy = filterBy
        self.sortBy = sortBy
        self.fetchLimit = limit
    }
}

extension Array where Array == [Root] {
    var itemsSummary: [itemSummaries]? {
        return self.first?.itemSummaries
    }
}

//Root Constains and Array of all items with summaries
struct itemSummaries:Codable {
    private let itemId: String?,
                title: String?,
                itemWebUrl: String?,
                condition: String?,
                itemHref: String?,
                itemGroupHref: String?,
                price: price?,
                image: thumbnailImages?,
                thumbnailImages: [thumbnailImages]?,
                additionalImages: [thumbnailImages]?,
                shippingOptions: [shippingOptions]?
    
    var hrefURL: String? {
        get {
                let itemHrefURL = itemHref?.replacingOccurrences(of: "|", with: "%7C"), // | is not recognizes or converted as valid parameter
                    groupHrefURL = itemGroupHref
            return groupHrefURL != nil ? groupHrefURL : itemHrefURL
        }
    }
    
    var itemTitle: String {
        return title ?? "No Title Found"
    }
    
    var fullPrice: String {
        let price = "\(self.price?.currency ?? "Unknown Currency") $\(self.price?.value ?? "0.0")"
        return price
    }
    
    var imgURL: String {
        return self.image?.imageUrl ?? "Invalid URL"
    }

    var webURL: String {
        return self.itemWebUrl ?? "Invalid URL"
    }

    var shipping: String {
        return self.shippingOptions?.first?.shippingCostType == "CALCULATED" ? "+ Shipping" : "• Free Shipping"
    }
}

//Item Shipping
struct shippingOptions:Codable {
    let shippingCostType: String?
}

//Price
struct price:Codable {
    let value: String?,
        currency: String?
}

//Thumbnail Image
struct thumbnailImages:Codable {
    let imageUrl: String?
}
