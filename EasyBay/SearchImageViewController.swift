//
//  SearchImageViewController.swift
//  EasyBay
//
//  Created by Rohit Nema on 3/2/19.
//  Copyright © 2019 Rohit Nema. All rights reserved.
//

import UIKit
import CoreML;

class SearchImageViewController: UIViewController {

  var responseJSON: Dictionary<String, Any> = [:]
  
  private let reuseIdentifier = "ProductCell"
  var results: [ProductCells] = []
  
  
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
      
      results.append(product)
    }
  }

}

extension SearchImageViewController : UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
    
    cell.productImageView.load(url: results[indexPath.item].imageURL)
    cell.productTitle.text = results[indexPath.item].title
    cell.sellerName.text = results[indexPath.item].seller
    cell.setPrice(price: results[indexPath.item].price)
    if (indexPath.item < 2) {
      cell.setRecommmended()
    } else {
      cell.setNotRecommended()
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(results[indexPath.item].title)
  }
}

extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}

