import UIKit

class InputParamsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  var vSpinner : UIView?

  @IBOutlet weak var budgetTextField: UITextField!
  @IBOutlet weak var usedPickerView: UIPickerView!
  @IBOutlet weak var pincodeTextField: UITextField!
  
  let pickerData = ["New", "Old"]
  
  var image = UIImage()
  var responseJSON: Dictionary<String, Any> = [:]
    
  
  @IBAction func searchButton(_ sender: Any) {
    
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
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    self.view.addSubview(activityIndicator)
    activityIndicator.frame = self.view.bounds
    activityIndicator.startAnimating()
    
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
    
    let maxAmt = budgetTextField.text
    
    
    let session = URLSession.shared
    var request = URLRequest(url: URL(string: "https://api.ebay.com/buy/browse/v1/item_summary/search_by_image?&limit=20&filter=price:[..1000]")!)
    request.httpMethod = "POST"
    
    // convert image to base64
    let imageData = UIImage.jpegData(image)
    let strBase64 = imageData(0.5)?.base64EncodedString(options: .lineLength64Characters)
    let params = ["image":  strBase64!] as Dictionary<String, String>
    
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
        //print(responseJSON)
        self.responseJSON = responseJSON
      }
      sem.signal()
    })
    task.resume()
    sem.wait()
    activityIndicator.stopAnimating()
    performSegue(withIdentifier: "segueSearchResults", sender: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    budgetTextField.placeholder = ""
    pincodeTextField.placeholder = ""
    // Connect data:
    self.usedPickerView.delegate = self
    self.usedPickerView.dataSource = self
  
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destVC = segue.destination as! SearchImageViewController
    destVC.responseJSON = responseJSON
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  
  // Capture the picker view selection
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print(row)
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
