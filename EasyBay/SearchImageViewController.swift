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
    let model = my_model()

  var responseJSON: Dictionary<String, Any> = [:]
  
  private let reuseIdentifier = "ProductCell"
  var results: [ProductCells] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let x:Bool=checkIfScam();
    print(x)
    
    for item in (responseJSON["itemSummaries"] as! [[String: Any]])  {
      let product = ProductCells()
        var id : String
        var p: Double
      product.title = item["title"] as! String
      id = item["itemId"] as! String
      if let prices = (item["price"] as? [String : Any]) {
        product.price = Double((prices["value"] as! NSString).floatValue)
        p = Double((prices["value"] as! NSString).floatValue)
      }
      
        var fPercentage: Double
        var fScore: Int
        
    if let sellerDetails = (item["seller"] as? [String : Any]) {
        fPercentage=sellerDetails["feedbackPercentage"] as! Double
        fScore=sellerDetails["feedbackScore"] as! Int
        product.seller = sellerDetails["username"] as! String
    }
        
        if let sellerDetails = (item["seller"] as? [String : Any]) {
            fPercentage=sellerDetails["feedbackPercentage"] as! Double
            fScore=sellerDetails["feedbackScore"] as! Int
            product.seller = sellerDetails["username"] as! String
        }
        
      if let image = (item["image"] as? [String : Any]) {
        product.imageURL = URL(string: image["imageUrl"] as! String)!
      }
//      print(product.title)
//      print(product.price)
//      print(product.seller)
//      print(product.imageURL)
        
        
      
      results.append(product)
    }
  }
    
    
    func checkIfScam() -> Bool {
        
        guard let mlMultiArray = try? MLMultiArray(shape:[7], dataType:MLMultiArrayDataType.double) else {
            fatalError("Unexpected runtime error. MLMultiArray")
        }
        
        for i in 1...7
        {
           mlMultiArray[i] = i as NSNumber
        }
        
        guard let my_modelOutput = try? model.prediction(input1 : mlMultiArray ) else {
            fatalError("Unexpected runtime error.")
        }
        
        let probLegit = my_modelOutput.output1[0] as! Double
        let probScam = my_modelOutput.output1[1] as! Double
        print(probLegit)
        print(probScam)
        return (probScam>probLegit)
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



