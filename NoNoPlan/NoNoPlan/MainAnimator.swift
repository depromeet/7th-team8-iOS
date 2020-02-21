//
//  MainAnimator.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/02.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit


fileprivate let transitonDuration: TimeInterval = 1.0

enum AnimationType {
    case present
    case dismiss
}

class CardDetailAnimationTransition: NSObject {
    let animationType: AnimationType!
    
    init(animationType: AnimationType) {
        self.animationType = animationType
        super.init()
    }
}

extension CardDetailAnimationTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitonDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if animationType == .present {
            animationForPresent(using: transitionContext)
        } else {
            animationForDismiss(using: transitionContext)
        }
    }
    
    func animationForPresent(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        //1.Get fromVC and toVC
        let navi = transitionContext.viewController(forKey: .from) as? UINavigationController
        guard let fromVC = navi?.viewControllers.first as? HomeViewController else { return }
        let tableViewController = fromVC.swipeViewController.tabItems[fromVC.swipeViewController.currentIndex ?? 0].viewController as? MainViewController
        guard let toVC = transitionContext.viewController(forKey: .to) as? CustomNavigationController else { return }
        guard let toContentVC = toVC.viewControllers.first as? DetailViewController else { return }
        guard let selectedCell = tableViewController?.selectedCell else { return }
        
        let frame = selectedCell.convert(selectedCell.bgBackView.frame, to: fromVC.view)
        //2.Set presentation original size.
        toContentVC.view.frame = frame
        toContentVC.scrollView.cardView.frame.size.width = GlobalConstants.todayCardSize.width
        toContentVC.scrollView.cardView.frame.size.height = GlobalConstants.todayCardSize.height
        
        containerView.addSubview(toVC.view)
        
        //3.Change original size to final size with animation.
        UIView.animate(withDuration: transitonDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            toContentVC.view.frame = UIScreen.main.bounds
            toContentVC.scrollView.cardView.frame.size.width = kScreenW
            toContentVC.scrollView.cardView.frame.size.height = GlobalConstants.cardDetailTopImageH
          //  toVC.closeBtn.alpha = 1
            
           // fromVC.tabBar.frame.origin.y = kScreenH
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
    
    func animationForDismiss(using transitionContext: UIViewControllerContextTransitioning) {
      
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CustomNavigationController else { return }
        guard let fromContentVC = fromVC.viewControllers.first as? DetailViewController else { return }
        fromVC.setNavigationBarHidden(true, animated: false)
        let navi = transitionContext.viewController(forKey: .to) as? UINavigationController
        guard let toVC = navi?.viewControllers.first as? HomeViewController else { return }
        let tableViewController = toVC.swipeViewController.tabItems[toVC.swipeViewController.currentIndex ?? 0].viewController as? MainViewController
        guard let selectedCell = tableViewController?.selectedCell else { return }
        
        UIView.animate(withDuration: transitonDuration , delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            let frame = selectedCell.convert(selectedCell.contentView.frame, to: toVC.view)
            fromVC.view.frame = .init(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height)
            fromContentVC.view.layer.cornerRadius = GlobalConstants.toDayCardCornerRadius
            fromContentVC.scrollView.cardView.frame.size.width = 0
            fromContentVC.scrollView.cardView.frame.size.height = selectedCell.frame.height
           // fromVC.closeBtn.alpha = 0
            fromContentVC.scrollView.cardView.translatesAutoresizingMaskIntoConstraints = false; fromContentVC.scrollView.cardView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
          //  toVC.tabBar.frame.origin.y = kScreenH - toVC.tabBar.frame.height
        }) { (completed) in
            transitionContext.completeTransition(completed)
           // toVC.view.addSubview(toVC.tabBar)
        }
    }
    
}




class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
}

extension CustomNavigationController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardDetailAnimationTransition(animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardDetailAnimationTransition(animationType: .dismiss)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CardPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
