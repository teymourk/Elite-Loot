//
//  FilterOptions.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/4/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol FilterOptions {
    var sectionTitle: String { get }
    var options: [EnumTitles] { get }
}

protocol EnumTitles {
    var name: String { get }
}

extension FilterOptions {
    var sectionTitle: String {
        return String(describing: Self.self)
    }
}

extension EnumTitles {
    var name: String {
        return String(describing: self).replacingOccurrences(of: "_", with: " ")
    }
}

struct Sort: FilterOptions {
    var options: [EnumTitles] { return [option.Best_Match, option.Lowest_Price, option.Highest_Price] }
    
    enum option: String, Codable, EnumTitles {
        case Best_Match = "fieldgroups=MATCHING_ITEMS&"
        case Lowest_Price = "sort=price&"
        case Highest_Price = "sort=-price&"
    }
}

struct Filters: FilterOptions {
    var options: [EnumTitles] { return [option.All_Items, option.Toys, option.Clothing] }
    
    enum option: String, Codable, EnumTitles {
        case All_Items = "1249,1059,220,15687,155183,63859,155206" //Viedeo Games | Toys | Cothing
        case Toys = "220" //Toys and Hobbies
        case Clothing = "15687,155183,63859,155206" //Mens T-Shirts + Sweaters | Woments Clothing
    }
}

struct Price: FilterOptions {
    
    var options: [EnumTitles] { return [prices.range(NSRange(location: 0, length: 100))] }
    
    enum prices: EnumTitles {
        case range(NSRange)
    }
}

