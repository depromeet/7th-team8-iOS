//
//  LoginViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/02/21.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit
import Lottie
class LoginViewController: UIViewController {
    
    let animationView = AnimationView(name:"lf20_1CqKbZ")
    
    private let loginButton: KOLoginButton = {
    let button = KOLoginButton()
    button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    self.modalPresentationStyle = .fullScreen
    self.modalTransitionStyle = .coverVertical
    animationView.contentMode = .scaleAspectFill
    animationView.loopMode = .autoReverse
    animationView.play()
    animationView.animationSpeed = 2
    
    
    layout()
  }
  
  @objc private func touchUpLoginButton(_ sender: UIButton) {
    guard let session = KOSession.shared() else {
      return
    }
    
    if session.isOpen() {
      session.close()
    }
    
    session.open { (error) in
      if error != nil || !session.isOpen() { return }
      KOSessionTask.userMeTask(completion: { (error, user) in
        guard let user = user,
              let email = user.account?.email,
              let nickname = user.nickname else { return }
        
       
       let navi = UINavigationController(rootViewController: HomeViewController())
        navi.modalPresentationStyle = .fullScreen
        navi.modalTransitionStyle = .coverVertical
        self.present(navi, animated: false, completion: nil)
        
      })
    }
  }

  private func layout() {
    let guide = view.safeAreaLayoutGuide
    view.addSubview(loginButton)
    view.addSubview(animationView)
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
     animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -200).isActive = true
    animationView.widthAnchor.constraint(equalToConstant: 133).isActive = true
    animationView.heightAnchor.constraint(equalToConstant: 99).isActive = true
    
    loginButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
    loginButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
    loginButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -30).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
}



