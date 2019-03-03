//
//  LaunchScreenController.swift
//  EasyBay
//
//  Created by Aryan Arora on 3/2/19.
//  Copyright © 2019 Rohit Nema. All rights reserved.
//

import UIKit

class LaunchScreenController : UIViewController {
    @IBOutlet weak var loadingLabel : UILabel!
    @IBOutlet weak var eLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.loadingLabel.transform = CGAffineTransform(translationX: 10, y: 0)
            self.eLabel.transform = CGAffineTransform(translationX: -10, y: 0)
            self.view.backgroundColor = UIColor.white
            
            
        }) {(success) in
            let sb = UIStoryboard(name: "Main" , bundle: nil)
            print("hi")
            let vc = sb.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = vc
        
        }
    }
}
