//
//  MainViewCotroller.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2019/12/28.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit



class MainViewController: UIViewController {
     let testText: [String] = ["동백키친", "섭지코지 섭지코지 섭지코지 섭지코지", "청춘부부"]
    private var expandedCell: CardCell?
    private var isStatusBarHidden = false
    private var hiddenCells: [CardCell] = []
    var scrollDelegate: HomeScrollDelegate?
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "메인화면"
        return label
    }()
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 20, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 30
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width - 20, height: 1)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    var selectedCell: CardCell?
    
    var statusBarShouldBeHidden = false
    //we need to set `View controller-based status bar appearance = YES` in info.plist.
    //so we can be able to hide statusBar.
    override var prefersStatusBarHidden: Bool {
        return statusBarShouldBeHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        label.frame = CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100)
       // view.addSubview(label)
        view.backgroundColor = UIColor(r: 252, g: 252, b: 252)
        collectionView.backgroundColor = UIColor(r: 252, g: 252, b: 252)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.register(CardCell.self)
        
        
    }
}


extension MainViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
        selectedCell = cell
        
        let detailVC = DetailViewController(cell: cell)
        
        detailVC.dismissClosure = { [weak self] in
            guard let StrongSelf = self else { return }
//            StrongSelf.updateStatusBarAndTabbarFrame(visible: true)
        }
         present(detailVC, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CardCell
        
        if indexPath.row % 2 == 0 {
            cell.cardView.placeLabel.text = testText[1]
        } else {
            cell.cardView.placeLabel.text = testText[2]
        }
//        VerticalStack {
//            Text("\(indexPath.section)")
//            Text("\(indexPath.row)")
//        }.build(on: cell.contentView)
       // cell.backgroundColor = .purple
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        guard let row = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
//        UIView.animate(withDuration: 0.3) {
//            row.bgBackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }
//        
//        
//    }
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        guard let row = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
//        UIView.animate(withDuration: 0.3) {
//            row.bgBackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }
//    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 400)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 20, left: 10, bottom: 0, right: 10)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
//    }
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var direction: ScrollDirection = .down
        let scrollOffset = scrollView.contentOffset.y
        let currentOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if (scrollOffset >= 0 && scrollOffset < currentOffset) {
            // currently, scrrolling..
            let scrollGesture = scrollView.panGestureRecognizer
            if scrollGesture.translation(in: scrollView.superview).y > 0 {
             // scrolling.. to up
                direction = .up
            } else {
                direction = .down
            //scrolling to down
            }
        }
        
        scrollDelegate?.scrollDidScroll(scrollView, offset: scrollView.contentOffset.y, direction: direction)
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("end")
        scrollDelegate?.scrollDidEnd(scrollView, offset: scrollView.contentOffset.y)
    }
    
}


import SwiftUI

struct mainView: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<mainView.ContainerView>) -> UIViewController {
            return UINavigationController (rootViewController: MainViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<mainView.ContainerView>) {
            
        }
    }
}
