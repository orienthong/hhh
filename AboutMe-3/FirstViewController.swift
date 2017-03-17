//
//  FirstViewController.swift
//  AboutMe-2
//
//  Created by Hao Dong on 13/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class FirstViewController: MasterViewController {
    
    var myDesign: UIImageView!
    
    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setUpImage()
        startAnimation()
    }
    
    func setUpImage() {
        myDesign = UIImageView()
        view.insertSubview(myDesign, belowSubview: topView)
        myDesign.image = #imageLiteral(resourceName: "Group 4")
        myDesign.contentMode = .scaleAspectFit
        layoutImage(with: traitCollection.verticalSizeClass)
    }
    func layoutImage(with trait: UIUserInterfaceSizeClass) {
        myDesign.translatesAutoresizingMaskIntoConstraints = false
        myDesign.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myDesign.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myDesign.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 2).isActive = true
        myDesign.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myDesign.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        switch trait {
        case .compact: //hc
            myDesign.contentMode = .top
        default:
            myDesign.contentMode = .scaleAspectFit
        }
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        let constraints = topView.constraints
        topView.removeConstraints(constraints)
        layoutTopView(with: newCollection.verticalSizeClass)
        
        myDesign.removeConstraints(myDesign.constraints)
        layoutImage(with: newCollection.verticalSizeClass)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Animation
    override func startAnimation() {
        super.startAnimation()
        configureAnimation()
        animator.startAnimation()
    }
    func configureAnimation() {
        myDesign.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        myDesign.alpha = 0.6
        myDesign.center.y -= 20
        animator = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut, animations: {
            self.myDesign.transform = .identity
            self.myDesign.alpha = 1.0
            self.myDesign.center.y += 20
        })
    }

}
