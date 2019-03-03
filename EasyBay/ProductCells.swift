//
//  ProductCells.swift
//  EasyBay
//
//  Created by Rohit Nema on 3/2/19.
//  Copyright © 2019 Rohit Nema. All rights reserved.
//

import Foundation

class ProductCells {
  var imageURL: URL
  var price: Double
  var seller: String
  var suspicion: Bool
  var title: String
  init() {
    imageURL = URL(string: "https://www.ebay.com")!
    price = 0.0
    seller = ""
    suspicion = false
    title = ""
  }
}
