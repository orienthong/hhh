//
//  ForthViewController.swift
//  AboutMe-3
//
//  Created by Hao Dong on 18/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class ForthViewController: MasterViewController {
    
    var imageView: UIImageView!
    
    var flag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutViews()
    }
    
    func setUpViews() {
        imageView = UIImageView()
        imageView.image = UIImage(named: "IMG_4191.png")!
        imageView.contentMode = .scaleAspectFit
        view.insertSubview(imageView, belowSubview: visualEffectView)
        
    }
    
    func layoutViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 375/281.0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func startAnimation() {
        super.startAnimation()
        UIView.transition(with: imageView, duration: 1.0, options: [.transitionCrossDissolve], animations: {
            self.imageView.image = (self.flag == 0) ? UIImage(named: "IMG_5340.png")! : UIImage(named: "IMG_4191.png")!
        }, completion: { finished in
            if finished {
                self.flag = (self.flag == 0) ? 1 : 0
                print(self.flag)
            }
        })
    }
    

}
