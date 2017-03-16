//
//  ThirdViewController.swift
//  AboutMe-2
//
//  Created by Hao Dong on 13/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    enum SlideViewOperation : Int {
        case push
        case pop
    }
    var slideView: UIView!
    var slidePropertyAnimator: UIViewPropertyAnimator!
    var visualViewAnimator: UIViewPropertyAnimator!
    var visualEffectView: UIVisualEffectView?
    
    var panRecognizer: UIPanGestureRecognizer!
    var backgroundImage = UIImageView()
    var slideUp = true
    private var operation: SlideViewOperation = .push
    
    var slideViewStartDragPosition: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        setUpImageView()
        
        let effect: UIVisualEffect? = UIBlurEffect(style: .extraLight)
        visualEffectView = UIVisualEffectView(effect: nil)
        visualEffectView?.frame = view.bounds
        visualEffectView?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(visualEffectView!)
        
        addSlideView()
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panSlideView(_:)))
        slideView.addGestureRecognizer(panRecognizer)
        
        
        visualViewAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .easeOut, animations: {
            self.visualEffectView?.effect = effect
        })
        
        
    }
    private func progress() -> CGFloat {
        print(operation)
        if operation == .push {
            return abs(1 - (slideView.center.y - view.center.y) / view.center.y)
        } else {
            return (slideView.center.y - view.center.y) / view.center.y
        }
    }
    
    func panSlideView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let effect: UIVisualEffect? = UIBlurEffect(style: .extraLight)
            visualViewAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .easeOut, animations: {
                self.visualEffectView?.effect = effect
            })
            slideViewStartDragPosition = slideView.center
        case .changed:
            let translation = sender.translation(in: view)
            
            slideView.center.y += translation.y
            
//            print("slideView.center.y\(slideView.center.y)")
            //print("translation.y\(translation.y)")

            let progress = self.progress()
//            print("view.center.y\(view.center.y)")
//            print("progress\(progress)")
            print("progress\(progress)")
            visualViewAnimator.fractionComplete = progress
            print(visualViewAnimator.fractionComplete)
//            let animationVelocity = sender.velocity(in: view)
//            print(animationVelocity)
            
            sender.setTranslation(CGPoint.zero, in: view)
//            let percentComplete = slidePropertyAnimator.fractionComplete + progressStepFor(translation: translation)
        case .cancelled, .ended:
            endInteraction()
        default:
            break
        }
    }
    
    private func endInteraction() {
        let completionPosition = self.completionPosition()
        animate(completionPosition)
    }
    private func completionPosition() -> UIViewAnimatingPosition {
        let completionThreshold: CGFloat = 0.33
        let flickMagnitude: CGFloat = 1200 //pts/sec
        let velocity = panRecognizer.velocity(in: view).toVector
        let isFlick = (velocity.magnitude > flickMagnitude)
        let isFlickDown = isFlick && (velocity.dy > 0.0)
        let isFlickUp = isFlick && (velocity.dy < 0.0)
        
        
        // if slideView.startDrag position in the center of the view, that mean we should pop it to its original position
        print(slideViewStartDragPosition.y)
        if slideViewStartDragPosition.y == view.frame.maxY {
            operation = .push
        } else {
            operation = .pop
        }
        if (operation == .push && isFlickUp) || (operation == .pop && isFlickDown) {
            return .end
        } else if (operation == .push && isFlickDown) || (operation == .pop && isFlickUp) {
            return .start
        } else if visualViewAnimator.fractionComplete > completionThreshold {
            return .end
        } else {
            return .start
        }
    }

    private func convert(_ velocity: CGPoint) -> CGVector {
        
        
        let dx = abs(view.center.x - slideView.center.x)
        let dy = abs(view.center.y - slideView.center.y)
        
        guard dx > 0.0 && dy > 0.0 else {
            return CGVector.zero
        }
        
        let range = CGFloat(35.0)
        let clippedVx = clip(-range, range, velocity.x / dx)
        let clippedVy = clip(-range, range, velocity.y / dy)
        return CGVector(dx: clippedVx, dy: clippedVy)
    }
    
    private func timingCurveVelocity() -> CGVector {
        // Convert the gesture recognizer's velocity into the initial velocity for the animation curve
        let gestureVelocity = panRecognizer.velocity(in: view)
        return convert(gestureVelocity)
    }
    
    func animate(_ toPosition: UIViewAnimatingPosition) {
        let timingParameters = UISpringTimingParameters(mass: 4.5, stiffness: 1300, damping: 95, initialVelocity: timingCurveVelocity())
        slidePropertyAnimator = UIViewPropertyAnimator(duration: 0.8, timingParameters: timingParameters)
        slidePropertyAnimator.addAnimations {
            if self.operation == .push {
                self.slideView.center.y = (toPosition == .end ? self.view.center.y : self.view.frame.maxY)
            } else {
                self.slideView.center.y = (toPosition == .end ? self.view.frame.maxY : self.view.center.y)
            }
        }
        
        slidePropertyAnimator.startAnimation()
        
        visualViewAnimator.isReversed = (toPosition == .start)
        
        visualViewAnimator.addCompletion { (position) in
            if position == .end {
                print(self.visualViewAnimator.state.rawValue)
                print("end visualViewAnimator")
            }
        }
        
        if visualViewAnimator.state == .inactive {
            print("startAnimator")
            visualViewAnimator.addAnimations {
                self.visualEffectView?.effect = nil
            }
            visualViewAnimator.startAnimation()
        } else {
            print("continute animator")
            // Calculate the duration factor for which to continue the animation.
            // This has been chosen to match the duration of the property animator created above
            let durationFactor = CGFloat(slidePropertyAnimator.duration / visualViewAnimator.duration)
            visualViewAnimator.continueAnimation(withTimingParameters: nil, durationFactor: durationFactor)
        }
    }
    
    
    func addSlideView() {
        slideView = UIView()
        view.addSubview(slideView)
        slideView.backgroundColor = #colorLiteral(red: 0.6507938504, green: 0.7373572588, blue: 0.9272412658, alpha: 1)
        slideView.translatesAutoresizingMaskIntoConstraints = false
        
        slideView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slideView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        // 1/2 height
        slideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        // 1/2 out of main view
        slideView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height / 4).isActive = true
        slideView.isUserInteractionEnabled = true
        
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
    
    func startAnimation() {
        print("third")
    }

}
