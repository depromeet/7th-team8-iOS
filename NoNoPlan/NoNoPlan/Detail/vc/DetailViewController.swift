//
//  DetailViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/02.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var dismissClosure: (()->())?
    //the point when start to interactive
    var interactiveStartingPoint: CGPoint? = nil
    
   lazy var draggingDownToDismiss = isNotscrolledContent()
    
    let cell: CardCell!
    var originSize: CGSize = .zero
    private lazy var dismissPanGesture: UIPanGestureRecognizer = {
        let ges = UIPanGestureRecognizer()
        ges.maximumNumberOfTouches = 1
        ges.addTarget(self, action: #selector(handleDismissPan(gesture:)))
        ges.delegate = self
        return ges
    }()
    
    lazy var scrollView: DetailScrollView = {
        let frame = self.view.bounds
        let view = DetailScrollView(frame: frame)
        view.delegate = self
        view.detailScrollDelegate = self
        
        return view
    }()
    
    
    init(cell: CardCell) {
        self.cell = cell
        super.init(nibName: nil, bundle: nil)
        self.setupTranstion()
    }
    
    private func setupTranstion() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getImageFromCell()
        originSize = self.view.frame.size
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.layer.masksToBounds = true
        view.addSubview(scrollView)
        view.addGestureRecognizer(dismissPanGesture)
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewDidDisappear(animated)
    }
    
    private func getImageFromCell() {
      //  scrollView.imageView.image = UIImage(named: "Card")
        //scroll
    }
    
    @objc private func closeAction() {
        dismiss(animated: true, completion: nil)
        dismissClosure?()
    }
    
    @objc private func handleDismissPan(gesture: UIPanGestureRecognizer) {
        if !draggingDownToDismiss {
            
            return
        }
        
        let startingPoint: CGPoint
        
        if let p = interactiveStartingPoint {
            startingPoint = p
        } else {
            
            startingPoint = gesture.location(in: nil)
            
            interactiveStartingPoint = startingPoint
        }
        
        let currentLocation = gesture.location(in: nil)
        
        var progress = (currentLocation.y - startingPoint.y) / 100
        
        var progressX = (currentLocation.x - startingPoint.x) / 100
        //prevent viewController bigger when scrolling up
        if currentLocation.y <= startingPoint.y {
            progress = 0
        }
        
        if currentLocation.x <= startingPoint.x {
            progressX = 0
        }
        if progress >= 1.0 {
            dismiss(animated: true, completion: nil)
            dismissClosure?()
            stopDismissPanGesture(gesture)
            return
        }
        
        if progressX >= 1.0 {
            dismiss(animated: true, completion: nil)
            dismissClosure?()
            stopDismissPanGesture(gesture)
            return
        }
        
        let targetShrinkScale: CGFloat = 0.86
        let currentScale: CGFloat = 1 - (1 - targetShrinkScale) * progress
        
        switch gesture.state {
        case .began,.changed:
            scrollView.isScrollEnabled = false
            gesture.view?.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
            gesture.view?.layer.cornerRadius = GlobalConstants.toDayCardCornerRadius * (progress)
            scrollView.showsVerticalScrollIndicator = false
        case .cancelled,.ended:
            scrollView.isScrollEnabled = true
            stopDismissPanGesture(gesture)
        default:
            break
        }
    }
    
   
    private func stopDismissPanGesture(_ gesture: UIPanGestureRecognizer) {
        draggingDownToDismiss = isNotscrolledContent()
        interactiveStartingPoint = nil
        scrollView.showsVerticalScrollIndicator = true
        
        UIView.animate(withDuration: 0.2) {
            gesture.view?.transform = CGAffineTransform.identity
        }
    }
    
    func isNotscrolledContent() -> Bool {
        if self.scrollView.contentSize.height <= originSize.height {
            return true
        } else {
            return false
        }
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
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

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset = .zero
            draggingDownToDismiss = true
        }
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension DetailViewController: DetailScrollDelegate {
    func moveReviewWriting() {
        let review = ReviewWritingViewController()
        review.titleString = scrollView.cardView.placeLabel.text ?? ""
        self.navigationController?.pushViewController(review, animated: true)
    }
    
    
    func moveDetail() {
        self.navigationController?.pushViewController(ReviewViewController(), animated: true)
    }
}



class CardPresentationController: UIPresentationController {
    
    private lazy var blurView = UIVisualEffectView(effect: nil)
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    override func presentationTransitionWillBegin() {
        let container = containerView!
        blurView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(blurView)
        blurView.edges(to: container)
        blurView.alpha = 0.0
        
        presentingViewController.beginAppearanceTransition(false, animated: false)
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (ctx) in
            self.blurView.effect = UIBlurEffect(style: .light)
            self.blurView.alpha = 1
        }) { (ctx) in }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
    }
    
    override func dismissalTransitionWillBegin() {
        presentingViewController.beginAppearanceTransition(true, animated: true)
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (ctx) in
            self.blurView.alpha = 0.0
            
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
        if completed {
            blurView.removeFromSuperview()
        }
    }
}

extension UIView {
    
    // Constrain 4 edges of `self` to specified `view`.
    func edges(to view: UIView, top: CGFloat=0, left: CGFloat=0, bottom: CGFloat=0, right: CGFloat=0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        ])
    }
    
    // Set view's cornerRadius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}


extension String {
    /// Calculate text's height from `width` and `front`.
    func calculateHeightWith(width: CGFloat, font: UIFont)-> CGFloat {
        let attr = [NSAttributedString.Key.font: font]
        let maxSize: CGSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        return self.boundingRect(with: (maxSize), options: option, attributes: attr, context: nil).size.height
    }
}
