//
//  MainViewCotroller.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2019/12/28.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private var expandedCell: CardCell?
    private var isStatusBarHidden = false
    private var hiddenCells: [CardCell] = []
    
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "메인화면"
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .blue
        label.frame = CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100)
       // view.addSubview(label)
        
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
        
        cell.bgImageView.image = UIImage(named: "Card")
//        VerticalStack {
//            Text("\(indexPath.section)")
//            Text("\(indexPath.row)")
//        }.build(on: cell.contentView)
       // cell.backgroundColor = .purple
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let row = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
        UIView.animate(withDuration: 0.3) {
            row.bgBackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let row = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
        UIView.animate(withDuration: 0.3) {
            row.bgBackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
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
