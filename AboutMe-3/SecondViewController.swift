//
//  SecondViewController.swift
//  AboutMe-2
//
//  Created by Hao Dong on 13/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class SecondViewController: MasterViewController {
    
    
    var textView: UITextView!
    var rectangleView: UIImageView!
    var stickerLabel: UILabel!
    
    var animator: UIViewPropertyAnimator!
    var stickerAnimator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1529880464, green: 0.1675317287, blue: 0.2100167572, alpha: 1)
        setUpView()
    }
    
    func setUpView() {
        //textView
        textView = UITextView()
        view.insertSubview(textView, belowSubview: visualEffectView)
        textView.text = "#include”stdio.h”" + "\n"+"int main( )\n{\n    printf(" + "" + "”Hello, World.\\n”);"+"\n}"
        textView.isUserInteractionEnabled = false
        textView.adjustsFontForContentSizeCategory = true
        textView.font = UIFont.systemFont(ofSize: 25)
        textView.backgroundColor = UIColor.white.withAlphaComponent(0)
        textView.textColor = #colorLiteral(red: 0.9766530395, green: 0.9984158874, blue: 0.9990937114, alpha: 1)
        
        
        //rectangleView
        rectangleView = UIImageView()
        rectangleView.image = #imageLiteral(resourceName: "Rectangle")
        view.insertSubview(rectangleView, belowSubview: visualEffectView)
        
        //stickerLabel
        stickerLabel = UILabel()
        view.insertSubview(stickerLabel, belowSubview: visualEffectView)
        stickerLabel.text = "🤔"
        stickerLabel.font = UIFont.systemFont(ofSize: 150)
        stickerLabel.adjustsFontForContentSizeCategory = true
        stickerLabel.layer.masksToBounds = true
    }
    private func layoutViews() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rectangleView.widthAnchor.constraint(equalTo: rectangleView.heightAnchor, multiplier: 333.0/142.0).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 164).isActive = true
        rectangleView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 0).isActive = true
        
        stickerLabel.translatesAutoresizingMaskIntoConstraints = false
        stickerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stickerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func startAnimation() {
        let text = "#include\"stdio.h\"\nint main( )\n{\n    printf(\"Hello, World.\\n\");\n}"
        textView.text = ""
        configureAnimation()
        textView.animate(newText: text, characterDelay: 0.02)
        animator.startAnimation()
        stickerAnimator.startAnimation()
        
    }
    
    private func configureAnimation() {
//        let timingParameters = UISpringTimingParameters(mass: 4.5, stiffness: 1300, damping: 95, initialVelocity: )
        let timing = UISpringTimingParameters(mass: 4.5, stiffness: 1300, damping: 95, initialVelocity: CGVector(dx: 0.5, dy: 0.5))
        animator = UIViewPropertyAnimator(duration: 1.5, timingParameters: timing)
        rectangleView.center.y += 20
        rectangleView.alpha = 0.6
        rectangleView.transform = CGAffineTransform(rotationAngle: 0.5)
        rectangleView.transform = CGAffineTransform(scaleX: 2, y: 2)
        animator.addAnimations ({
            self.rectangleView.center.y -= 20
            self.rectangleView.transform = .identity
            self.rectangleView.alpha = 1.0
        }, delayFactor: 1.0)
        stickerLabel.alpha = 0.0
        stickerLabel.transform = CGAffineTransform(scaleX: 3, y: 3)
        stickerAnimator = UIViewPropertyAnimator(duration: 1.5, timingParameters: timing)
        stickerAnimator.addAnimations ({
            self.stickerLabel.alpha = 1.0
            self.stickerLabel.transform = .identity
        }, delayFactor: 1.0)

    }
    

}

