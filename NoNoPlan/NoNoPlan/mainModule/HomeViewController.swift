//
//  HomeViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/14.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    let navigationBar: UIView = UIView(frame: .zero)
    let swipeViewController = SwipeTabController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 144).isActive = true
        navigationBar.backgroundColor = .red
        
        
        swipeViewController.navigationBar = navigationBar
        let vc1 = UIViewController()
         let vc2 = MainViewController()
         vc1.view.backgroundColor = .cyan
         vc2.view.backgroundColor = .gray
         let vc3 = UIViewController()
         vc3.view.backgroundColor = .yellow
         
         let vc4 = UIViewController()
        
         swipeViewController.tabItems = [(vc1, "전체"), (vc2, "관광지"),(vc3, "맛집"), (vc4, "카페")]
         swipeViewController.option.currentColor = UIColor.black
         swipeViewController.option.titleColor = .black
        
        addChild(swipeViewController)
        swipeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swipeViewController.view)
        swipeViewController.didMove(toParent: self)
        swipeViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        swipeViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        swipeViewController.view.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        swipeViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
