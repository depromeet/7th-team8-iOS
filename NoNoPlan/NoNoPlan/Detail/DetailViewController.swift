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
        return view
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: kScreenW - 20 - 30, y: 20, width: 30, height: 30)
        btn.backgroundColor = .red
        // btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        btn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return btn
    }()
    
    init(cell: CardCell) {
        self.cell = cell
        super.init(nibName: nil, bundle: nil)
        self.setupTranstion()
    }
    
    private func setupTranstion() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
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
        view.addSubview(closeBtn)
        view.addGestureRecognizer(dismissPanGesture)
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    private func getImageFromCell() {
        scrollView.imageView.image = UIImage(named: "Card")
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

//import SwiftUI
//
//struct detailView: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        func makeUIViewController(context: UIViewControllerRepresentableContext<detailView.ContainerView>) -> UIViewController {
//            return UINavigationController (rootViewController: DetailViewController())
//        }
//        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<detailView.ContainerView>) {
//
//        }
//    }
//}



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


class DetailScrollView: UIScrollView {
    
    let bgBackView = UIView()
    let imageView = UIImageView()
    let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        bgBackView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: GlobalConstants.cardDetailTopImageH)
        bgBackView.layer.masksToBounds = true
        
        imageView.frame = bgBackView.bounds
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        
        let textViewWidth = kScreenW - 2 * textViewLeftMargin
        let font = UIFont.boldSystemFont(ofSize: 15)
        let textHeight = textViewText.calculateHeightWith(width: textViewWidth, font: font)
        textView.frame = CGRect(x: textViewLeftMargin, y: bgBackView.frame.height + textViewTopMargin, width: textViewWidth, height: textHeight + textViewBottomMargin)
        textView.text = textViewText
        textView.font = font
        textView.textColor = .gray
        
        bgBackView.addSubview(imageView)
        addSubview(bgBackView)
        addSubview(textView)
        
        contentSize = CGSize(width: kScreenW, height: bgBackView.frame.height + textViewTopMargin + textView.frame.height + textViewBottomMargin)
    }
    
}


fileprivate let textViewLeftMargin: CGFloat = 20
fileprivate let textViewTopMargin: CGFloat = 40
fileprivate let textViewBottomMargin: CGFloat = 50
fileprivate let textViewText = "일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고 운동도하고 일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고 운동도하고 일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고 일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고 운동도하고 일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고 운동도하고 일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고 일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고 운동도하고 일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고 운동도하고 일도하고 프로젝트도 하고 토이프로젝트도 하고 밥도 먹고 그러다 책도 읽고 티비도 보고 영화도 보고 물도 마시고 카페도 가고 산책도 하고 놀러도 가고 호캉스도 즐기고 게임도 하고"



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
