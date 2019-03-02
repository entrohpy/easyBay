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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    var request = URLRequest(url: URL(string: "https://api.ebay.com/buy/browse/v1/item_summary/search_by_image?&limit=3&sort=-price")!)
    let session = URLSession.shared
    request.httpMethod = "POST"
    
    // convert image to base64
    let imageData = UIImage.jpegData(image!)
    
    let strBase64 = imageData(0.5)?.base64EncodedString(options: .lineLength64Characters)
    
    let params = ["image":  strBase64!] as Dictionary<String, String>
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer v^1.1#i^1#p^1#r^0#f^0#I^3#t^H4sIAAAAAAAAAOVXbWwURRju9YuPUkUhfJSKxyJRhNub3b293q3cheuXnClt4Y6vAjZzu7N07d3usTNHe2BMOUzRoEWKYBBUhBpjYiKIxAQTQmKM+IfIHxINRq0xQWKiEIxEUZzdHuVaCVA4gcT7c5l33nnned7nfWd2QFfpmMe7F3T/Xu4YVbi3C3QVOhxcGRhTWjLnvqLCipICkOPg2Nv1SFdxpujMPAwT8aS0GOGkoWPk7EzEdSzZxgCTMnXJgFjDkg4TCEtEliKhhQ0SzwIpaRrEkI044wzXBhiPonrEWMznqQKIhx6ZWvUrMaNGgEGy6lE9QOYR8Ai8wtF5jFMorGMCdRJgeMD5XUBwAT7KcZIgSEBk/R6hhXEuRSbWDJ26sIAJ2nAle62Zg/X6UCHGyCQ0CBMMh+ojTaFwbV1jdJ47J1Ywm4cIgSSFh45qDAU5l8J4Cl1/G2x7S5GULCOMGXdwYIehQaXQFTC3AN9ONefxCyoEHOSQqvhEb15SWW+YCUiuj8OyaIpLtV0lpBONpG+UUZqN2DNIJtlRIw0RrnVaf4tSMK6pGjIDTF11aEWouZkJhsw01EOm4aqDOF0N067mxbUuL+dVkOhVZJegIFWo8irZfQaCZbM8bKMaQ1c0K2fY2WiQakRBo+Gp4XNSQ52a9CYzpBILUK6fcCWFQlWLpemAiCnSpluyogTNg9Me3liAwdWEmFosRdBghOETdoYCDEwmNYUZPmmXYrZ6OnGAaSMkKbndHR0dbIfAGuYaNw8A516+sCEit6EEZCxfq9dtf+3GC1yaTUVGdCXWJJJOUiydtFQpAH0NExR8Is9VZfM+FFZwuPVfhhzO7qENka8G8YqCgESfWCXzCvKjvDRIMFujbgsHitHSTECzHZFkHMrIJdM6SyWQqSmSIKq84FORS/H6VZfHr6qumKh4XZyKEEAoFpP9vv9Rn9xspUdkI4majbgmp/NT73mrdVNphiZJR1A8Tg03W/TXJIktkneAntXrI6BoxcA0CExqrFXarGwk3AakZ5plarVR3xbvUDIZTiRSBMbiKJyn8+zunGXXpKfRy/6e4kT1GxBSUwZuadZWk8XrZNZE2EiZ9AOFbbJurajRjnR6CBDTiMeRuZS7baHvMX1HdlTeGu08XtMjpk17nf3vSluOa7SCWu8au7soqgbJvUWaE0VO5L1U1dviVWNLGk3fkZtoBPQWGJigm5ZsBB+V7qEv3GCB/eMyjsMg4zhIH8nADWZxM8GM0qIlxUXjKrBGEKtBlcXaGp0+3EzEtqN0EmpmYaljZeWB91pz3tR7V4Mpg6/qMUVcWc4TG1RenSnh7p9czvmBAHiOEwQgtoCZV2eLuUnFEw89269qoV0THM99XT3p3J4D6bazU0H5oJPDUVJQnHEUVMSe3iSfbyn98CWl/+D+o2/t3/FQj9q/+9dH57ZGA19NWSVv6HuqvOKb1XXS5pdPPrG8IbjTt/toZU39eu782BP9+7c+8PP4Sx8vu9D7/rQvzi3/aPNlXdzzy+HtR56fsPWDo9WZtUvmjm/4+68z0e82FPy2+M9ji7aPzpz+vnfHpdmfB+f0dJ4+dfnh14oLU6t+enV2w751neltb/zQ/WZfPb9p6saTGy/OMx/7cku0u2RLxa7m6T0rX2lvjM4vm/iOtuj1camzF6b29qzYfWb0jLqOU0VHVhjHKj/ra9wHGt+d3Td9yrkXVvWCH8dOfnJcV8n6zNpP+z75Y1rL/Jbjy0bBWQ8mjn9buvPtE9tq+y6+eGhAvn8Am/6iGu0QAAA=", forHTTPHeaderField: "Authorization")
    
    
    let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
      print("Response: \(String(describing: response))")})
    
    task.resume()
    
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
