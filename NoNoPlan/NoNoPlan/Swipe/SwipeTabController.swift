//
//  SwipeTabController.swift
//  Testing
//
//  Created by jeongjinho on 2020/01/06.
//  Copyright © 2020 jeongjinho. All rights reserved.
//

import UIKit

protocol SwipeTabDelegate {
    func didMoveTab(_ index: Int)
}

class SwipeTabController: UIViewController {
    var delegate: SwipeTabDelegate?
    let pageController = TabPageViewController()
    lazy fileprivate var tabView: TabView = self.configuredTabView()
    open var isInfinity: Bool = false
    open var option: TabPageOption = TabPageOption()
    open var tabItems: [(viewController: UIViewController, title: String)] = []
    var currentIndex: Int? {
        guard let viewController = pageController.viewControllers?.first else {
            return nil
        }
        return tabItems.map{ $0.viewController }.firstIndex(of: viewController)
    }
    fileprivate var beforeIndex: Int = 0
    fileprivate var tabItemsCount: Int {
        return tabItems.count
    }
    fileprivate var defaultContentOffsetX: CGFloat {
        return self.view.bounds.width
    }
    fileprivate var shouldScrollCurrentBar: Bool = true
    fileprivate var statusView: UIView?
    fileprivate var statusViewHeightConstraint: NSLayoutConstraint?
    fileprivate var tabBarTopConstraint: NSLayoutConstraint?
    var navigationBar: UIView? = nil
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupPageViewController()
        setupScrollView()
        //updateNavigationBar()
       // self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.sizeToFit()
    }
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if tabView.superview == nil {
            tabView = configuredTabView()
        }

        if let currentIndex = currentIndex , isInfinity {
            tabView.updateCurrentIndex(currentIndex, shouldScroll: true)
        }
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

       // updateNavigationBar()
        tabView.layouted = true
      
        
          //Important!
          
          //Default NavigationBar Height is 44. Custom NavigationBar Height is 66. So We should set additionalSafeAreaInsets to 66-44 = 22
         
              
            
          
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    
    fileprivate func setupPageViewController() {
        pageController.dataSource = pageController
        pageController.delegate = pageController
        pageController.tabItems = tabItems
        pageController.automaticallyAdjustsScrollViewInsets = false
        pageController.delegate2 = self
        pageController.setViewControllers([tabItems[pageController.beforeIndex].viewController],
                           direction: .forward,
                           animated: false,
                           completion: nil)
        self.addChild(pageController)
        self.view.addSubview(pageController.view)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageController.view.topAnchor.constraint(equalTo: tabView.bottomAnchor).isActive = true
        pageController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageController.didMove(toParent: self)
    }

    fileprivate func setupScrollView() {
        // Disable PageViewController's ScrollView bounce
        let scrollView = view.subviews.flatMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = pageController
        scrollView?.backgroundColor = option.pageBackgoundColor
    }
    
    fileprivate func updateNavigationBar() {
//           if let navigationBar = navigationController?.navigationBar {
//               navigationBar.shadowImage = UIImage()
//               navigationBar.setBackgroundImage(option.tabBackgroundImage, for: .default)
//               navigationBar.isTranslucent = option.isTranslucent
//           }
        setUpNavigationBarTitleImage()
       }
    
    func setUpNavigationBarTitleImage() {

        let navController = navigationController!

        let image = UIImage(named: "logo")!
        let imageView = UIImageView(image: image)

        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height

        imageView.frame = CGRect(x: 0, y: 150, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        imageView.center = navController.navigationBar.center
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 414, height: 300)
       // navigationItem.title
        
    }
    
    fileprivate func configuredTabView() -> TabView {
        let tabView = TabView(isInfinity: isInfinity, option: option)
        tabView.translatesAutoresizingMaskIntoConstraints = false

        let height = NSLayoutConstraint(item: tabView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1.0,
                                        constant: option.tabHeight)
        tabView.addConstraint(height)
        view.addSubview(tabView)
        guard let naviBar = navigationBar else { return  tabView }
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        let top =  tabView.topAnchor.constraint(equalTo: view.topAnchor)
        top.isActive = true
        tabView.heightAnchor.constraint(equalToConstant: option.tabHeight).isActive = true
//        let top = NSLayoutConstraint(item: tabView,
//                                     attribute: .top,
//                                     relatedBy: .equal,
//                                     toItem: topLayoutGuide,
//                                     attribute: .bottom,
//                                     multiplier:1.0,
//                                     constant: 144.0)
//
//        let left = NSLayoutConstraint(item: tabView,
//                                      attribute: .leading,
//                                      relatedBy: .equal,
//                                      toItem: view,
//                                      attribute: .leading,
//                                      multiplier: 1.0,
//                                      constant: 0.0)
//
//        let right = NSLayoutConstraint(item: view,
//                                       attribute: .trailing,
//                                       relatedBy: .equal,
//                                       toItem: tabView,
//                                       attribute: .trailing,
//                                       multiplier: 1.0,
//                                       constant: 100.0)
//
//        view.addConstraints([top, left, right])
        
        tabView.pageTabItems = tabItems.map({ $0.title})
        tabView.updateCurrentIndex(pageController.beforeIndex, shouldScroll: true)

        tabView.pageItemPressedBlock = { [weak self] (index: Int, direction: UIPageViewController.NavigationDirection) in
            self?.displayControllerWithIndex(index, direction: direction, animated: true)
        }

        tabBarTopConstraint = top

        return tabView
    }
 

}


extension SwipeTabController {

    public func displayControllerWithIndex(_ index: Int, direction: UIPageViewController.NavigationDirection, animated: Bool) {
        
        pageController.beforeIndex = index
        pageController.shouldScrollCurrentBar = false
        let nextViewControllers: [UIViewController] = [tabItems[index].viewController]

        let completion: ((Bool) -> Void) = { [weak self] _ in
            self?.pageController.shouldScrollCurrentBar = true
            self?.pageController.beforeIndex = index
            self?.delegate?.didMoveTab(index)
        }

        pageController.setViewControllers(
            nextViewControllers,
            direction: direction,
            animated: animated,
            completion: completion)

        guard pageController.isViewLoaded else { return }
        tabView.updateCurrentIndex(index, shouldScroll: true)
    }
}


extension SwipeTabController: delegate2 {
    func updateFromBeforeToCurrentIndex(_ index: Int, shouldScroll: Bool) {
        tabView.updateCurrentIndex(index, shouldScroll: shouldScroll)
       // self.pageController.beforeIndex = index
    }
    
    func updateCurrentIndex(_ index: Int, shouldScroll: Bool) {
        tabView.updateCurrentIndex(index, shouldScroll: shouldScroll)
    }
    
    func scrollCurrentBarView(_ index: Int, contentOffsetX: CGFloat) {
        tabView.scrollCurrentBarView(index, contentOffsetX: contentOffsetX)
    }
    
    func scrollToHorizontalCenter() {
        self.pageController.shouldScrollCurrentBar = true
        tabView.scrollToHorizontalCenter()
    }
    
    func updateCollectionViewUserInteractionEnabled(_ userInteractionEnabled: Bool) {
        tabView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled)
    }

    
}
