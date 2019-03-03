//
//  SearchImageViewController.swift
//  EasyBay
//
//  Created by Rohit Nema on 3/2/19.
//  Copyright © 2019 Rohit Nema. All rights reserved.
//

import UIKit
import CoreML

class SearchImageViewController: UIViewController {
  let model = my_model()
  
  var imageJSONs: [Dictionary<String, Any>] = []
  var responseJSON: Dictionary<String, Any> = [:]
  
  private let reuseIdentifier = "ProductCell"
  var results: [ProductCells] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    let x:Bool=checkIfScam();
//    print(x)
    
    for json in imageJSONs {
      for item in (json["itemSummaries"] as! [[String: Any]])  {
        let product = ProductCells()
//        var id : String
//        var p: Double
        product.title = item["title"] as! String
//        id = item["itemId"] as! String
        if let prices = (item["price"] as? [String : Any]) {
          product.price = Double((prices["value"] as! NSString).floatValue)
//          p = Double((prices["value"] as! NSString).floatValue)
        }
        
//        var fPercentage: Double
//        var fScore: Int
        
        //      if let sellerDetails = (item["seller"] as? [String : Any]) {
        //        fPercentage=sellerDetails["feedbackPercentage"] as! Double
        //        fScore=sellerDetails["feedbackScore"] as! Int
        //        product.seller = sellerDetails["username"] as! String
        //      }
        //
              if let sellerDetails = (item["seller"] as? [String : Any]) {
//                fPercentage=sellerDetails["feedbackPercentage"] as! Double
//                fScore=sellerDetails["feedbackScore"] as! Int
                product.seller = sellerDetails["username"] as! String
              }
        
        if let image = (item["image"] as? [String : Any]) {
          product.imageURL = URL(string: image["imageUrl"] as! String)!
        }
        print(product.title)
        print(product.price)
        print(product.seller)
        print(product.imageURL)
        
//
//        // HTTP Requests
//        let oauthSession = URLSession.shared
//
//        // generate OAuth Application token
//        var oauthToken: String? = nil
//
//        var oauthRequest = URLRequest(url: URL(string: "https://api.ebay.com/identity/v1/oauth2/token")!)
//        oauthRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content_Type")
//        oauthRequest.addValue("Basic QXJ5YW5Bcm8tRWFzeUJheS1QUkQtNjE2ZGU1NmRjLTNkZWYzNzZkOlBSRC0xNmRlNTZkY2FkYTgtOTVhZi00YzJlLWFlN2QtYzFlMw==", forHTTPHeaderField: "Authorization")
//
//        let scope = "https://api.ebay.com/oauth/api_scope"
//        let encodedURL = scope.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        oauthRequest.httpBody = "grant_type=client_credentials&scope=\(encodedURL!)".data(using: .utf8)
//        oauthRequest.httpMethod = "POST"
//
////        let activityIndicator = UIActivityIndicatorView(style: .gray)
////        self.view.addSubview(activityIndicator)
////        activityIndicator.frame = self.view.bounds
////        activityIndicator.startAnimating()
//
//        let oauthSem = DispatchSemaphore(value: 0)
//        let oauthTask = oauthSession.dataTask(with: oauthRequest, completionHandler: {data, response, error in
//          guard let data = data, error == nil else {
//            print(error?.localizedDescription ?? "No  data")
//            return
//          }
//
//          let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//          if let responseJSON = responseJSON as? [String: Any] {
//            oauthToken = responseJSON["access_token"] as? String
//          }
//          oauthSem.signal()
//        })
//        oauthTask.resume()
//        oauthSem.wait()
      
      //let maxAmt = budgetTextField.text!
      
      
//      let session = URLSession.shared
//      var request = URLRequest(url: URL(string: "https://svcs.ebay.com/services/search/FindingService/v1")!)
//      request.httpMethod = "POST"
//
//      // convert image to base64
//      //        let imageData = UIImage.jpegData(image)
//      //        let strBase64 = imageData(0.5)?.base64EncodedString(options: .lineLength64Characters)
//      //        let params = ["image":  strBase64!] as Dictionary<String, String>
//
//      request.httpBody = try? JSONSerialization.data(withJSONObject: id, options: [])
//      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//      request.addValue("Bearer \(oauthToken!)", forHTTPHeaderField: "Authorization")
//      request.addValue("affiliateCampaignId=<ePNCampaignId>,affiliateReferenceId=<referenceId>", forHTTPHeaderField: "X-EBAY-C-ENDUSERCTX")
//
//      let sem = DispatchSemaphore(value: 0)
//      let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
//        guard let data = data, error == nil else {
//          print(error?.localizedDescription ?? "No data")
//          return
//        }
//        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//        if let responseJSON = responseJSON as? [String: Any] {
//          print(responseJSON)
//          self.responseJSON = responseJSON
//        }
//        sem.signal()
//      })
//      task.resume()
//      sem.wait()
//      activityIndicator.stopAnimating()
//
      results.append(product)
//    }
    }
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



