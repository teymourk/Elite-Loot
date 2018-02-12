//
//  BrowseAPI.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/11/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol BrowseAPI: Networking where Model == Merchendise {
    func searchByKeyWord(Key: String, completion: @escaping ([Merchendise]?) ->())
}

extension BrowseAPI {
    func searchByKeyWord(Key: String, completion: @escaping ([Merchendise]?) ->()) {
        guard let url = URL(string: "https://api.ebay.com/buy/browse/v1/item_summary/search?q=D\(Key)+2&price=10&limit=5") else { return }
        var merchendise:[Merchendise]? = [Merchendise]()
        requestData(forUrl: url) { (_response, _merchendise) in
            switch _response {
            case let .error(errorDesctiption):
                print(errorDesctiption)
                completion(nil)
            case let .success(successDesctiption):
                guard let merchObj = _merchendise else { return }
                merchendise?.append(merchObj)
                DispatchQueue.main.async {
                    completion(merchendise)
                    print(successDesctiption)
                }
            }
        }
    }
}
