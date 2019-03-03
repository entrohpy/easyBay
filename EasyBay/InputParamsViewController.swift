import UIKit

class InputParamsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet weak var budgetTextField: UITextField!
  @IBOutlet weak var usedPickerView: UIPickerView!
  @IBOutlet weak var pincodeTextField: UITextField!
  
  let pickerData = ["New", "Old"]
  
  var image: UIImage?
  var keywords: [String]?
  var responseJSON: Dictionary<String, Any> = [:]
  var imageJSONs: [Dictionary<String, Any>] = []
  
  func createJSONRequest(base64: String) -> Dictionary<String, Any> {
    return(
      [
        "requests":
          [
            [
              "image": [
                "content": base64
              ],
              "features":
                [
                  [
                    "type": "OBJECT_LOCALIZATION",
                    ],
              ]
            ],
        ]
      ])
  }
  
  func cropImage(image: UIImage, xmin: CGFloat, xmax: CGFloat, ymin: CGFloat, ymax: CGFloat) -> UIImage {
    let rect = CGRect(x: CGFloat(xmin), y: CGFloat(ymin), width: CGFloat(xmax - xmin), height: CGFloat(ymax - ymin));
    let croppedCGImage = image.cgImage?.cropping(to: rect)
    let croppedImage = UIImage(cgImage: croppedCGImage!)
    return croppedImage
  }
  
  func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
      newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
      newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  
  func convertImageToBase64(image: UIImage) -> String {
    let imageData = image.jpegData(compressionQuality: 0.75)!
    //let imageData = image.pngData()!
    return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
  }
  
  func convertBase64ToImage(imageString: String) -> UIImage {
    let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
    return UIImage(data: imageData)!
  }
  
  func imgSearch(image: String) -> [UIImage] {
    let jsonData = try? JSONSerialization.data(withJSONObject: createJSONRequest(base64: image))
    let image2 = convertBase64ToImage(imageString: image)
    let url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyAWe1PTG1dkiGHOAZNNqaua8OlFxJLQpJw")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    var resJSON: [String : Any] = [String : Any]()
    
    let oauthSem = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      if let responseJSON = responseJSON as? [String: Any] {
        //print(responseJSON)
        resJSON = responseJSON
        oauthSem.signal()
      }
    }
    task.resume()
    oauthSem.wait()
    var images: [UIImage] = []
    //var vals: [[CGFloat]] = []
    for object in resJSON["responses"] as! [[String: Any]] {
      let subObjects = object["localizedObjectAnnotations"] as! [[String : Any]]
      for subObject in subObjects {
        //print(subObject["name"] as! String)
        let boundingPoly = subObject["boundingPoly"]!
        let normVerts = (boundingPoly as! [String : Any])["normalizedVertices"]!
//        print(normVerts)
        var tempVals: [CGFloat] = []
        for pair in normVerts as! [Any] {
          for (_, val) in pair as! [String : Any] {
            //print (coord)
            //print(val)
            tempVals.append(CGFloat((val as! NSNumber).floatValue))
            //print(tempVals) //y,x,y,x,y,x,y,x
          }
          
        }
        //vals.append([tempVals[0], tempVals[2], tempVals[1], tempVals[5]])
        //cropImage(image: image2, xmin: tempVals[0], xmax: tempVals[2], ymin: tempVals[1], ymax: tempVals[5])
        if tempVals[0] == tempVals[2] {
          images.append(cropImage(image: image2, xmin: tempVals[1]*image2.size.width, xmax: tempVals[5]*image2.size.width, ymin: tempVals[0]*image2.size.height, ymax: tempVals[4]*image2.size.height))
//          print([tempVals[1], tempVals[5], tempVals[0], tempVals[4]])
        }
        else {
          images.append(cropImage(image: image2, xmin: tempVals[0]*image2.size.width, xmax: tempVals[2]*image2.size.width, ymin: tempVals[1]*image2.size.height, ymax: tempVals[5]*image2.size.height))
//          print([tempVals[0], tempVals[2], tempVals[1], tempVals[5]])
        }
        //            images.append(cropImage(image: image2, xmin: tempVals[0]*image2.size.width, xmax: tempVals[2]*image2.size.width, ymin: tempVals[1]*image2.size.height, ymax: tempVals[5]*image2.size.height))
        //            print([tempVals[0], tempVals[2], tempVals[1], tempVals[5]])
      }
    }
    var final: [UIImage] = []
//    print(images)
    for thing in images {
//      print (thing)
      final.append(thing)
      let temp = imgSearch2(image2: convertImageToBase64(image: thing))
//      print (temp)
      for stuff in temp {
        final.append(stuff)
      }
    }
    return final
  }
  
  func imgSearch2(image2: String) -> [UIImage] {
    let jsonData = try? JSONSerialization.data(withJSONObject: createJSONRequest(base64: image2))
    let image3 = convertBase64ToImage(imageString: image2)
    let url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyAWe1PTG1dkiGHOAZNNqaua8OlFxJLQpJw")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    var resJSON: [String : Any] = [String : Any]()
    
    let oauthSem = DispatchSemaphore(value: 0)
    var images: [UIImage] = []
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      if let responseJSON = responseJSON as? [String: Any] {
        //print(responseJSON)
        resJSON = responseJSON
        oauthSem.signal()
      }
    }
    task.resume()
    oauthSem.wait()
    //var vals: [[CGFloat]] = []
    if resJSON["responses"] != nil {
      for object in resJSON["responses"] as! [[String: Any]] {
        let subObjects = object["localizedObjectAnnotations"] as! [[String : Any]]
        for subObject in subObjects {
          //print(subObject["name"] as! String)
          let boundingPoly = subObject["boundingPoly"]!
          let normVerts = (boundingPoly as! [String : Any])["normalizedVertices"]!
          //print(normVerts)
          var tempVals: [CGFloat] = []
          for pair in normVerts as! [Any] {
            for (_, val) in pair as! [String : Any] {
              //print (coord)
              //print(val)
              tempVals.append(CGFloat((val as! NSNumber).floatValue))
              //print(tempVals) //y,x,y,x,y,x,y,x
            }
            
          }
          if tempVals[0] == tempVals[2] {
            images.append(cropImage(image: image3, xmin: tempVals[1]*image3.size.width, xmax: tempVals[5]*image3.size.width, ymin: tempVals[0]*image3.size.height, ymax: tempVals[4]*image3.size.height))
//            print([tempVals[1], tempVals[5], tempVals[0], tempVals[4]])
          }
          else {
            images.append(cropImage(image: image3, xmin: tempVals[0]*image3.size.width, xmax: tempVals[2]*image3.size.width, ymin: tempVals[1]*image3.size.height, ymax: tempVals[5]*image3.size.height))
//            print([tempVals[0], tempVals[2], tempVals[1], tempVals[5]])
          }
          //vals.append([tempVals[0], tempVals[2], tempVals[1], tempVals[5]])
          //cropImage(image: image2, xmin: tempVals[0], xmax: tempVals[2], ymin: tempVals[1], ymax: tempVals[5])
          //                images.append(cropImage(image: image3, xmin: tempVals[0]*image3.size.width, xmax: tempVals[2]*image3.size.width, ymin: tempVals[1]*image3.size.height, ymax: tempVals[5]*image3.size.height))
          //print([tempVals[0], tempVals[2], tempVals[1], tempVals[5]])
        }
      }
    }
    return images
  }
  
  @IBAction func searchButton(_ sender: Any) {
    
    // convert image to base64
    
    // HTTP Requests
    let oauthSession = URLSession.shared
    
    // generate OAuth Application token
    var oauthToken: String? = nil
    
    var oauthRequest = URLRequest(url: URL(string: "https://api.ebay.com/identity/v1/oauth2/token")!)
    oauthRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content_Type")
    oauthRequest.addValue("Basic QXJ5YW5Bcm8tRWFzeUJheS1QUkQtNjE2ZGU1NmRjLTNkZWYzNzZkOlBSRC0xNmRlNTZkY2FkYTgtOTVhZi00YzJlLWFlN2QtYzFlMw==", forHTTPHeaderField: "Authorization")
    
    let scope = "https://api.ebay.com/oauth/api_scope"
    let encodedURL = scope.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
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
    
    image = ResizeImage(image: image!, targetSize: CGSize(width: (image?.size.width)!/4, height: (image?.size.height)!/4))
    
    let images = imgSearch(image: convertImageToBase64(image: image!))
    
    for img in images {
      let imageData = img.jpegData(compressionQuality: 1)
      let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
      let params = ["image":  strBase64!] as Dictionary<String, String>
      
      let session = URLSession.shared
      var request = URLRequest(url: URL(string: "https://api.ebay.com/buy/browse/v1/item_summary/search_by_image?&limit=5&filter=price:[..\(budgetTextField.text ?? "100000")],priceCurrency:USD,deliveryPostalCode:\(pincodeTextField.text ?? "90024"),deliveryCountry:US")!)
      request.httpMethod = "POST"
      request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.addValue("Bearer \(oauthToken!)", forHTTPHeaderField: "Authorization")
      request.addValue("affiliateCampaignId=<ePNCampaignId>,affiliateReferenceId=<referenceId>", forHTTPHeaderField: "X-EBAY-C-ENDUSERCTX")
      
      let sem = DispatchSemaphore(value: 0)
      
      let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
        guard let data = data, error == nil else {
          print(error?.localizedDescription ?? "No data")
          return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
          print(responseJSON)
          self.responseJSON = responseJSON
          self.imageJSONs.append(responseJSON)
        }
        sem.signal()
      })
      task.resume()
      sem.wait()
    }
    
    performSegue(withIdentifier: "segueSearchResults", sender: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    budgetTextField.placeholder = ""
    pincodeTextField.placeholder = ""
    // Connect data:
    self.usedPickerView.delegate = self
    self.usedPickerView.dataSource = self
    
    self.hideKeyboardWhenTappedAround()
    //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
    //tap.cancelsTouchesInView = false
    
    
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destVC = segue.destination as! SearchImageViewController
    destVC.responseJSON = self.responseJSON
    destVC.imageJSONs = self.imageJSONs
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  
  // Capture the picker view selection
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//    print(row)
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let titleData = pickerData[row]
    let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Avenir Next", size: 15.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
    return myTitle
  }
}

// Put this piece of code anywhere you like
extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
