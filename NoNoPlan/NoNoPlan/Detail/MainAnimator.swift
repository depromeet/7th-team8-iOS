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
        guard let fromVC = transitionContext.viewController(forKey: .from) as? SwipeTabController else { return }
        let tableViewController = fromVC.tabItems.first?.viewController as? MainViewController
        guard let toVC = transitionContext.viewController(forKey: .to) as? DetailViewController else { return }
        guard let selectedCell = tableViewController?.selectedCell else { return }
        
        let frame = selectedCell.convert(selectedCell.bgBackView.frame, to: fromVC.view)
        //2.Set presentation original size.
        toVC.view.frame = frame
        toVC.scrollView.imageView.frame.size.width = GlobalConstants.todayCardSize.width
        toVC.scrollView.imageView.frame.size.height = GlobalConstants.todayCardSize.height
        
        containerView.addSubview(toVC.view)
        
        //3.Change original size to final size with animation.
        UIView.animate(withDuration: transitonDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            toVC.view.frame = UIScreen.main.bounds
            toVC.scrollView.imageView.frame.size.width = kScreenW
            toVC.scrollView.imageView.frame.size.height = GlobalConstants.cardDetailTopImageH
            toVC.closeBtn.alpha = 1
            
           // fromVC.tabBar.frame.origin.y = kScreenH
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
    
    func animationForDismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? DetailViewController else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) as? SwipeTabController else { return }
        let tableViewController = toVC.tabItems.first?.viewController as? MainViewController
        guard let selectedCell = tableViewController?.selectedCell else { return }
        
        UIView.animate(withDuration: transitonDuration - 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            let point: CGPoint =  .init(x:selectedCell.bgBackView.frame.width - 50,y:selectedCell.bgBackView.frame.height - 50)
            let frame = selectedCell.convert(point, to: toVC.view)
            fromVC.view.frame = CGRect(x: frame.x, y: frame.y, width: 20, height: 20)
            fromVC.view.layer.cornerRadius = GlobalConstants.toDayCardCornerRadius
            fromVC.scrollView.imageView.frame.size.width = GlobalConstants.todayCardSize.width
            fromVC.scrollView.imageView.frame.size.height = GlobalConstants.todayCardSize.height
            fromVC.closeBtn.alpha = 0
            
          //  toVC.tabBar.frame.origin.y = kScreenH - toVC.tabBar.frame.height
        }) { (completed) in
            transitionContext.completeTransition(completed)
           // toVC.view.addSubview(toVC.tabBar)
        }
    }
    
}
