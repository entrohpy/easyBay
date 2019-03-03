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
   
    @IBOutlet weak var asy: UILabel!
    var lbl = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.asy.fadeOut()
//        eLabel.isHidden = true
//        loadingLabel.isHidden = true
        lbl = UILabel(frame: CGRect(x: self.view.center.x - 100, y: self.view.center.y, width: 230, height: 100))
        lbl.center = self.view.center
        lbl.center.x -= 25
        lbl.center.y -= 2
        lbl.textAlignment = .center //For center alignment
        lbl.text = "asy"
        lbl.alpha = 0
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 60)
        
        self.view.addSubview(lbl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.loadingLabel.transform = CGAffineTransform(translationX: 48, y: 0)
            self.eLabel.transform = CGAffineTransform(translationX: -33, y: 0)
            self.lbl.fadeIn()
            self.view.backgroundColor = UIColor.init(red: 0.176, green: 0.176, blue: 0.181, alpha: 1)
            
            
        }) {(success) in
            Thread.sleep(forTimeInterval:10 )
            let sb = UIStoryboard(name: "Main" , bundle: nil)
            let vc = sb.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = vc
        
        }
    }
}
