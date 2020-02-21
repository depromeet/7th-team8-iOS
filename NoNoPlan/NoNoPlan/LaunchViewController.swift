//
//  LauchViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/02/21.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit
import Lottie
class LaunchViewController: UIViewController {
    
    var yConstraint: NSLayoutConstraint?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(launchImageView)
        view.backgroundColor = .white
        
        let animationView = AnimationView(name:"lf20_1CqKbZ")
    
        
        
        animationView.contentMode = .scaleAspectFill
        view.addSubview(animationView)
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yConstraint = animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        yConstraint?.isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 133).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 99).isActive = true
        
        animationView.play { _ in
            self.yConstraint?.constant = -200
            UIView.animate(withDuration: 1, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
               // animationView.removeFromSuperview()
                self.view.window?.rootViewController = LoginViewController()
                
//                let navi = UINavigationController(rootViewController: HomeViewController())
//                       navi.modalPresentationStyle = .fullScreen
//                       navi.modalTransitionStyle = .coverVertical
////                       self.present(navi, animated: false, completion: nil)
//                  self.view.window?.rootViewController = navi
            }
            
            
            
        }
    }
}
