//
//  ProductCollectionViewCell.swift
//  EasyBay
//
//  Created by Rohit Nema on 3/2/19.
//  Copyright © 2019 Rohit Nema. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet var productImageView: UIImageView!
  @IBOutlet weak var productTitle: UILabel!
  @IBOutlet weak var sellerName: UILabel!
  @IBOutlet weak var recommended: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  func setRecommmended() {
    recommended.text = "RECOMMENDED"
  }
  
  func setNotRecommended() {
    recommended.text = ""
  }
  
  func setPrice(price: Double) {
    priceLabel.text = "Price: $" + (String(format: "%.2f", price) as String)
  }
}
