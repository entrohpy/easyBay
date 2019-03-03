//
//  SearchImageViewController.swift
//  EasyBay
//
//  Created by Rohit Nema on 3/2/19.
//  Copyright © 2019 Rohit Nema. All rights reserved.
//

import UIKit

class SearchImageViewController: UIViewController {

  var responseJSON: Dictionary<String, Any> = [:]
  
  private let reuseIdentifier = "ProductCell"
  private let sectionInsets = UIEdgeInsets(top: 50.0,
                                           left: 20.0,
                                           bottom: 50.0,
                                           right: 20.0)
  let results: [ProductCells] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for item in (responseJSON["itemSummaries"] as! [[String: Any]])  {
      let product = ProductCells()
      product.title = item["title"] as! String
      
      if let prices = (item["price"] as? [String : Any]) {
        product.price = Double((prices["value"] as! NSString).floatValue)
      }
      
      if let sellerDetails = (item["seller"] as? [String : Any]) {
        product.seller = sellerDetails["username"] as! String
      }
    
      if let image = (item["image"] as? [String : Any]) {
        product.imageURL = URL(string: image["imageUrl"] as! String)!
      }
      print(product.title)
      print(product.price)
      print(product.seller)
      print(product.imageURL)
    }
  }

}


private extension SearchImageViewController {
  func photo(for indexPath: IndexPath) -> ProductCells {
    return results[indexPath.section]
  }
}
