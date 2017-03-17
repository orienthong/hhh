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
        print(traitCollection.verticalSizeClass.rawValue)
        layoutView(with: traitCollection.verticalSizeClass)
        layoutStickerLabel()
    }
    func layoutTextView(with trait: UIUserInterfaceSizeClass) {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        switch trait {
        case .compact: //hc
            print("*********")
            textView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        case .regular: //hr
            print("*********")
            textView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 90).isActive = true
        case .unspecified:
            break
        }
    }
    func layoutRectangle(with trait: UIUserInterfaceSizeClass) {
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rectangleView.widthAnchor.constraint(equalTo: rectangleView.heightAnchor, multiplier: 333.0/142.0).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 164).isActive = true
        
        switch trait {
        case .compact: //hc
            rectangleView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: -57).isActive = true
        case .unspecified:
            fallthrough
        case .regular: //hr
            rectangleView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8).isActive = true
        }
    }
    func layoutStickerLabel() {
        stickerLabel.translatesAutoresizingMaskIntoConstraints = false
        stickerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stickerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    func layoutView(with trait: UIUserInterfaceSizeClass) {
        layoutTextView(with: trait)
        layoutRectangle(with: trait)
        //layoutStickerLabel(with: trait)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //layoutView(with: traitCollection.verticalSizeClass)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
//        let views = [textView, rectangleView, stickerLabel, topView] as [UIView]
//        for item in views {
//            let constrains = item.constraints
//            item.removeConstraints(constrains)
//        }
        
        textView.removeConstraints(textView.constraints)
        rectangleView.removeConstraints(rectangleView.constraints)
        //stickerLabel.removeConstraints(stickerLabel.constraints)
        topView.removeConstraints(topView.constraints)
        
        print(textView.constraints.count)
        print(rectangleView.constraints.count)
        print(stickerLabel.constraints.count)
        print(topView.constraints.count)
        
        
        
        print(newCollection.verticalSizeClass.rawValue)
        layoutTopView(with: newCollection.verticalSizeClass)
        
        layoutView(with: newCollection.verticalSizeClass)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func startAnimation() {
        print("second")
    }
    
    
    

}

