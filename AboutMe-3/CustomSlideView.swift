//
//  CustomSlideView.swift
//  AboutMe-3
//
//  Created by Hao Dong on 16/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class CustomSlideView: UIView {
    
    var slideButton: UIButton!
    
    
    override init(frame: CGRect) {
        slideButton = UIButton(type: .custom)
        super.init(frame: frame)
        
        self.addSubview(slideButton)
        slideButton.setTitle("", for: .normal)
        slideButton.setBackgroundImage(UIImage(named: "slideButtonUp.png"), for: .normal)
        slideButton.translatesAutoresizingMaskIntoConstraints = false
        slideButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        slideButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
