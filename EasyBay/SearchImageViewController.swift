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
    
<<<<<<< HEAD
//    let x:Bool=checkIfScam();
//    print(x)
    
    for json in imageJSONs {
      for item in (json["itemSummaries"] as! [[String: Any]])  {
        let product = ProductCells()
//        var id : String
//        var p: Double
        product.title = item["title"] as! String
        product.url = URL(string: item["itemWebUrl"] as! String)!
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
//        print(product.title)
//        print(product.price)
//        print(product.seller)
//        print(product.imageURL)
        
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
=======
    for item in (responseJSON["itemSummaries"] as! [[String: Any]])  {
      let product = ProductCells()
      var id : String
      var p: Double = 0.0
        var tempSum: Double = 0.0
        var tempCount: Double = 0.0
        var top: Double = 0.0
      product.title = item["title"] as! String
      id = item["itemId"] as! String
      if let prices = (item["price"] as? [String : Any]) {
        product.price = Double((prices["value"] as! NSString).floatValue)
        p = Double((prices["value"] as! NSString).floatValue)
      }
      
      var fPercentage: Double = 0.0
      var fScore: Int = 0
        var slr: String = "dirbot"
        var paypal: Double = 0
      if let sellerDetails = (item["seller"] as? [String : Any]) {
        fPercentage = Double((sellerDetails["feedbackPercentage"] as! NSString).floatValue)
        fScore = Int(sellerDetails["feedbackScore"] as! NSNumber)
        product.seller = sellerDetails["username"] as! String
        slr = sellerDetails["username"] as! String
      }
      
      
      
      if let image = (item["image"] as? [String : Any]) {
        product.imageURL = URL(string: image["imageUrl"] as! String)!
      }
//            print(product.title)
//            print(product.price)
//            print(product.seller)
//            print(product.imageURL)
      
//      let activityIndicator = UIActivityIndicatorView(style: .gray)
//      self.view.addSubview(activityIndicator)
//      activityIndicator.frame = self.view.bounds
//      activityIndicator.startAnimating()
      
      
      let session = URLSession.shared
      var request = URLRequest(url: URL(string: "https://svcs.ebay.com/services/search/FindingService/v1?limit=20")!)
      request.httpMethod = "POST"

//      // convert image to base64
//      //        let imageData = UIImage.jpegData(image)
//      //        let strBase64 = imageData(0.5)?.base64EncodedString(options: .lineLength64Characters)
//      //        let params = ["image":  strBase64!] as Dictionary<String, String>
//
        func xmlString() -> String {
            var xml = "<?xml version=\"1.0\"?>"
            xml += "<findItemsAdvancedRequest xmlns=\"http://www.ebay.com/marketplace/search/v1/services\">"
            xml += "<itemFilter>"
            xml += "<name>"
            xml += "Seller"
            xml += "</name>"
            xml += "<value>"
            xml += slr
            xml += "</value>"
            xml += "</itemFilter>"
            xml += "<itemFilter>"
            xml += "<name>PaymentMethod</name>"
            xml += "<value>PayPal</value>"
            xml += "</itemFilter>"
            xml += "<paginationInput>"
            xml += "<entriesPerPage>10</entriesPerPage>"
            xml += "<pageNumber>1</pageNumber>"
            xml += "</paginationInput>"
            xml += "<outputSelector>SellerInfo</outputSelector>"
            xml += "</findItemsAdvancedRequest>"
            
            return xml
        }
        
      
        request.httpBody = xmlString().data(using: .utf8)
      request.addValue("AryanAro-EasyBay-PRD-616de56dc-3def376d", forHTTPHeaderField: "X-EBAY-SOA-SECURITY-APPNAME")
      request.addValue("findItemsAdvanced", forHTTPHeaderField: "X-EBAY-SOA-OPERATION-NAME")
      request.addValue("json", forHTTPHeaderField: "X-EBAY-SOA-RESPONSE-DATA-FORMAT")

      let sem = DispatchSemaphore(value: 0)
      let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
        guard let data = data, error == nil else {
          print(error?.localizedDescription ?? "No data")
          return
        }
        let response1JSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let response1JSON = response1JSON as? [String: Any] {
          print(response1JSON)
        for items in response1JSON["findItemsAdvancedResponse"] as! [[String: Any]]{
                for res in items["searchResult"] as! [[String : Any]] {
                    for i in res["item"] as! [[String: Any]] {
                        for k in i["sellerInfo"] as! [[String: Any]] {
                            if((k["sellerUserName"]! as! [String])[0]==slr)
                            {
                                paypal=1.0
                                break
                            }
                        }
                    }
                }
            }
            
            
            
            
//            if let search = (response1JSON["searchResult"] as? [String : Any]){
//                if let item = (search["item"] as? [String : Any]){
//                        if let seller = (item["sellerInfo"] as? [String : Any]){
//                            if let temp = (seller["sellerUserName"] as! String! ){
//                                if(temp==slr){
//                                    paypal=true;
//
//                                }
//                            }
//                        }
//                    }
//                }
          //self.responseJSON = responseJSON
        }
        sem.signal()
      })
      task.resume()
        
        
        let session1 = URLSession.shared
        var request1 = URLRequest(url: URL(string: "https://svcs.ebay.com/services/search/FindingService/v1?limit=20")!)
        request1.httpMethod = "POST"
        
        //      // convert image to base64
        //      //        let imageData = UIImage.jpegData(image)
        //      //        let strBase64 = imageData(0.5)?.base64EncodedString(options: .lineLength64Characters)
        //      //        let params = ["image":  strBase64!] as Dictionary<String, String>
        //
        func xmlString1() -> String {
            var xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            xml += "<findCompletedItemsRequest xmlns=\"http://www.ebay.com/marketplace/search/v1/services\">"
            xml += "<itemFilter>"
            xml += "<name>Seller</name>"
            xml += "<value>"
            xml += slr
            xml += "</value>"
            xml += "</itemFilter>"
            xml += "<itemFilter>"
            xml += "<name>SoldItemsOnly</name>"
            xml += "<value>true</value>"
            xml += "</itemFilter>"
            xml += "<paginationInput>"
            xml += "<entriesPerPage>10</entriesPerPage>"
            xml += "<pageNumber>1</pageNumber>"
            xml += "</paginationInput>"
            xml += "</findCompletedItemsRequest>"
            
            
            return xml
        }
        
        
        request1.httpBody = xmlString1().data(using: .utf8)
        request1.addValue("AryanAro-EasyBay-PRD-616de56dc-3def376d", forHTTPHeaderField: "X-EBAY-SOA-SECURITY-APPNAME")
        request1.addValue("findCompletedItems", forHTTPHeaderField: "X-EBAY-SOA-OPERATION-NAME")
        request1.addValue("json", forHTTPHeaderField: "X-EBAY-SOA-RESPONSE-DATA-FORMAT")
        request1.addValue("EBAY-US", forHTTPHeaderField: "X-EBAY-SOA-GLOBAL-ID")
        
        
        let sem1 = DispatchSemaphore(value: 0)
        let task1 = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let response2JSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let response2JSON = response2JSON as? [String: Any] {
                print(response2JSON)
                print("*********************************************************")
                for items in response2JSON["findItemsAdvancedResponse"] as! [[String: Any]]{
                    for res in items["searchResult"] as! [[String : Any]] {
                        for i in res["item"] as! [[String: Any]] {
                            for k in i["sellingStatus"] as! [[String: Any]] {
                                for j in k["currentPrice"] as! [[String: Any]] {
                                        tempSum += Double((j["__value__"] as! NSString).floatValue)
                                        tempCount += 1
                                    }
                               
                            }
                            if (i["topRatedListing"] as! Bool == true){
                                top=1.0
                            }
                            
                        }
                    }
                }
                
                
                
                
                //            if let search = (response1JSON["searchResult"] as? [String : Any]){
                //                if let item = (search["item"] as? [String : Any]){
                //                        if let seller = (item["sellerInfo"] as? [String : Any]){
                //                            if let temp = (seller["sellerUserName"] as! String! ){
                //                                if(temp==slr){
                //                                    paypal=true;
                //
                //                                }
                //                            }
                //                        }
                //                    }
                //                }
                //self.responseJSON = responseJSON
            }
            sem1.signal()
        })
        task1.resume()
        
        
      sem1.wait()
      //activityIndicator.stopAnimating()

        guard let mlMultiArray = try? MLMultiArray(shape:[6], dataType:MLMultiArrayDataType.double) else {
            fatalError("Unexpected runtime error. MLMultiArray")
        }
        
        var movingcost = abs((tempSum/tempCount - p)/p)*100
        
        mlMultiArray[0] = fPercentage as NSNumber
        mlMultiArray[1] = fScore as NSNumber
        mlMultiArray[2] = paypal as NSNumber
        mlMultiArray[3] = movingcost as NSNumber
        mlMultiArray[4] = top as NSNumber
        mlMultiArray[5] = p as NSNumber
        
        product.suspicion = checkIfScam(mlMultiArray: mlMultiArray)
        
      results.append(product)
        print(paypal)
>>>>>>> master
    }
  }
  }
  
  
    func checkIfScam(mlMultiArray : MLMultiArray) -> Bool {
    
    
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let url = results[indexPath.item].url
    print(url)
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
    
    cell.productImageView.load(url: results[indexPath.item].imageURL)
    cell.productTitle.text = results[indexPath.item].title
    cell.sellerName.text = "sold by: " + results[indexPath.item].seller
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



