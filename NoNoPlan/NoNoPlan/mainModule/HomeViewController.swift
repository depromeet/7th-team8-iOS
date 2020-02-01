//
//  HomeViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/14.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit


enum ScrollDirection {
    case up
    case down
}
protocol HomeScrollDelegate {
    
    
    func scrollDidScroll(_ scrollView: UIScrollView, offset: CGFloat, direction: ScrollDirection)
    func scrollDidEnd(_ scrollView: UIScrollView, offset: CGFloat)
}

class HomeViewController: UIViewController {
    var isMovedTab: Bool = false
    var isFolding: Bool = false
    var currentOffset: CGFloat = 0
    let navigationBar: HomeNavigationBar = HomeNavigationBar()
    let swipeViewController = SwipeTabController()
    var naviYConstraint: NSLayoutConstraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
       naviYConstraint =  navigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        naviYConstraint?.isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 144).isActive = true
        
        
        
        swipeViewController.navigationBar = navigationBar
        let vc1 = MainViewController()
         let vc2 = MainViewController()
         vc1.view.backgroundColor = .cyan
         vc2.view.backgroundColor = .gray
         let vc3 = UIViewController()
         vc3.view.backgroundColor = .yellow
         
         let vc4 = UIViewController()
        vc2.scrollDelegate = self
        vc1.scrollDelegate = self
         swipeViewController.tabItems = [(vc1, "전체"), (vc2, "관광지"),(vc3, "맛집"), (vc4, "카페")]
         swipeViewController.option.currentColor = UIColor.black
         swipeViewController.option.titleColor = .black
        swipeViewController.delegate = self
        addChild(swipeViewController)
        swipeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swipeViewController.view)
        swipeViewController.didMove(toParent: self)
        swipeViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        swipeViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        swipeViewController.view.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        naviYConstraint?.isActive = true
        swipeViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
}

extension HomeViewController: SwipeTabDelegate {
    func didMoveTab(_ index: Int) {
        isMovedTab = true
        currentOffset = 0
    }
}

extension HomeViewController: HomeScrollDelegate {
    func scrollDidScroll(_ scrollView: UIScrollView, offset: CGFloat, direction: ScrollDirection) {
        
        if offset < 0 {
            return
        }

        var offsetY = offset
        //탭에서 폴딩이 아니면서 offset < 100 일 때
        
        if naviYConstraint?.constant != -100 && offset < 100 {
            if 144 - offsetY <= 44 {
                offsetY = 100
              
                self.naviYConstraint?.constant = -100
                
                UIView.animate(withDuration: 0.5, animations: {
                   
                    self.view.layoutIfNeeded()
                    
                })
                return
            }
            var alpha = 1 - (offsetY / 100)
                           print(alpha)
            navigationBar.components.forEach{$0.alpha = alpha}
            naviYConstraint?.constant = -offsetY
            
            //탭에서 폴딩 아니면서 offset > 100 일때
        } else if naviYConstraint?.constant ?? 0 >= CGFloat(-100.0) && offset > 100  {
            
            if 144 - offsetY <= 44 {
                offsetY = 100
                self.naviYConstraint?.constant = -100
                UIView.animate(withDuration: 0.5, animations: {
                   
                    self.view.layoutIfNeeded()
                    
                })
                return
            }
                     
            
            if  direction == .down {
                naviYConstraint?.constant = -offsetY
            }
             // 탭에서 폴딩 이면서 offset > 100
        } else if naviYConstraint?.constant ?? 0 <= CGFloat(-100.0) && offset > 100 {
            
                return
            // 탭에서 폴딩 이면서 offset < 100
        } else if naviYConstraint?.constant ?? 0 <= CGFloat(-100.0) && offset < 100 {
            if 144 - offsetY <= 44 {
                offsetY = 100
            }
            if  direction == .up {
                naviYConstraint?.constant = -offsetY
            }
            
        }

       currentOffset = offset
        
 
    }
    
    func scrollDidEnd(_ scrollView: UIScrollView, offset: CGFloat) {
        
        
        if naviYConstraint?.constant ?? 0 >= CGFloat(-50.0)  {
            
            if offset > 100 {
                naviYConstraint?.constant = -100
                navigationBar.components.forEach{$0.alpha = 0}
            } else {
                navigationBar.components.forEach{$0.alpha = 1}
                naviYConstraint?.constant = 0
                scrollView.contentOffset.y = 0
            }
            
          
        } else {
            if offset < 50 {
                naviYConstraint?.constant = 0
                navigationBar.components.forEach{$0.alpha = 1}
//                 scrollView.contentOffset.y = 0
            } else {
                naviYConstraint?.constant = -100
                navigationBar.components.forEach{$0.alpha = 0}
               
            }
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.view.layoutIfNeeded()
            
        })
       
//         if  naviYConstraint?.constant == -100 && offset > 100 {
//
//
//                   return
//               }
//
////        if isFolding && self.naviYConstraint?.constant == -100 {
////            return
////        }
//        if offset > 77 {
//            isFolding = true
//             self.naviYConstraint?.constant = -100
//            UIView.animate(withDuration: 0.3, animations: {
//                scrollView.contentOffset.y = 100
//                self.view.layoutIfNeeded()
//
//            })
//
//        } else if offset <= 77 {
//            isFolding = false
//            self.naviYConstraint?.constant = 0
//            UIView.animate(withDuration: 0.3, animations: {
//                scrollView.contentOffset.y = 0
//                self.view.layoutIfNeeded()
//            })
//        }
    }
    
   
   
}


extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
}
