//
//  GridImageViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/02/15.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit

extension GridImageCell: NibLoadableView, ReusableView {}
class GridImageCell: UICollectionViewCell {
    
    let gridImageView: UIImageView = {
       let gridImage = UIImageView()
        gridImage.image = UIImage(named: "Card")
        return gridImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(gridImageView)
        gridImageView.adjustToArea()
    }
    
}


class GridImageViewController: UIViewController {
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var collectionView: CustomCollectionView = {
        
        let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(collectionView)
        collectionView.adjustToArea()
        collectionView.register(GridImageCell.self)
    }
    
}

extension GridImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GridImageCell
        return cell
    }

}


extension GridImageViewController: UICollectionViewDelegate {
    
}



extension GridImageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 100)
    }
}
