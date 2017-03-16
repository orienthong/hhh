//
//  FirstViewController.swift
//  AboutMe-2
//
//  Created by Hao Dong on 13/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var backgroundImage = UIImageView()
    var visualEffectView: UIVisualEffectView?
    
    let imageRx = CGFloat(402.0/600)
    var imageWidth = CGFloat(0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setUpImageView()
        
        let effect: UIVisualEffect? = UIBlurEffect(style: .extraLight)
        visualEffectView = UIVisualEffectView(effect: effect)
        visualEffectView?.frame = view.bounds
        visualEffectView?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(visualEffectView!)
        
        UIView.animate(withDuration: 2, delay: 5, options: [], animations: {
            self.visualEffectView?.effect = nil
        }, completion: nil)
        
    }
    
    func startAnimation() {
        print("first")
    }
    
    func setUpImageView() {
        
        view.addSubview(backgroundImage)
        let roadPath = Bundle.main.path(forResource: "road", ofType: "png")
        backgroundImage.image = UIImage(contentsOfFile: roadPath!)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.isUserInteractionEnabled = false
        backgroundImage.layer.masksToBounds = true
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
