//
//  SearchImageViewController.swift
//  EasyBay
//
//  Created by Rohit Nema on 3/2/19.
//  Copyright © 2019 Rohit Nema. All rights reserved.
//

import UIKit

class SearchImageViewController: UIViewController {

  var image: UIImage?
  var response: Dictionary<String, Any>?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // HTTP Requests
    
    let oauthSession = URLSession.shared
    
    // generate OAuth Application token
    var oauthToken: String? = nil

    var oauthRequest = URLRequest(url: URL(string: "https://api.ebay.com/identity/v1/oauth2/token")!)
    oauthRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content_Type")
    oauthRequest.addValue("Basic QXJ5YW5Bcm8tRWFzeUJheS1QUkQtNjE2ZGU1NmRjLTNkZWYzNzZkOlBSRC0xNmRlNTZkY2FkYTgtOTVhZi00YzJlLWFlN2QtYzFlMw==", forHTTPHeaderField: "Authorization")

    let scope = "https://api.ebay.com/oauth/api_scope"
    let encodedURL = scope.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    \
    oauthRequest.httpBody = "grant_type=client_credentials&scope=\(encodedURL!)".data(using: .utf8)
    oauthRequest.httpMethod = "POST"

    let oauthSem = DispatchSemaphore(value: 0)
    let oauthTask = oauthSession.dataTask(with: oauthRequest, completionHandler: {data, response, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      if let responseJSON = responseJSON as? [String: Any] {
        oauthToken = responseJSON["access_token"] as? String
      }
      oauthSem.signal()
    })
    oauthTask.resume()
    oauthSem.wait()
    
    let session = URLSession.shared
    var request = URLRequest(url: URL(string: "https://api.ebay.com/buy/browse/v1/item_summary/search_by_image?&limit=5&sort=-price")!)
      request.httpMethod = "POST"

    // convert image to base64
    let imageData = UIImage.jpegData(image!)
    let strBase64 = imageData(0.8)?.base64EncodedString(options: .lineLength64Characters)
    let params = ["image":  strBase64!] as Dictionary<String, String>

    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(oauthToken!)", forHTTPHeaderField: "Authorization")
    request.addValue("affiliateCampaignId=<ePNCampaignId>,affiliateReferenceId=<referenceId>", forHTTPHeaderField: "X-EBAY-C-ENDUSERCTX")

    let sem = DispatchSemaphore(value: 0)
    let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      if let responseJSON = responseJSON as? [String: Any] {
        print(responseJSON)
      }
      sem.signal()
    })
    task.resume()
    sem.wait()

  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
