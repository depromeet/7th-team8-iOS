//
//  anotherPlaceViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/02/15.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit

extension AnotherPlaceCell: NibLoadableView, ReusableView {}
class AnotherPlaceCell: UICollectionViewCell {
    
    let categoryLabel: UILabel  = {
        let categoty = UILabel()
        categoty.numberOfLines = 0
        categoty.textColor = .purple
        categoty.text = "이탙리안"
        
        categoty.font = UIFont.systemFont(ofSize: 13)
        return categoty
    }()
    
    let placeLabel: UILabel = {
        let place = UILabel(frame: .zero)
        place.text = "섭지코지 섭지코지 섭지코지 섭지코지"
        place.lineBreakMode = .byWordWrapping
        place.numberOfLines = 1
        place.font = UIFont.boldSystemFont(ofSize: 18)
        return place
    }()
    
    let fromDistanceLabel: UILabel = {
        let fromDistance = UILabel()
        fromDistance.text = "내 위치에서 15km"
        fromDistance.textColor = UIColor(r: 122, g: 122, b: 122)
        fromDistance.font = UIFont.systemFont(ofSize: 13)
        return fromDistance
        
        
    }()

    let thumbnailView: UIImageView = {
       let thumbnail = UIImageView(image: UIImage(named: "Card"))
        thumbnail.layer.masksToBounds = true
        return thumbnail
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let backgroundView = UIView()
       // let backgroundView = UIView()
//        backgroundView.backgroundColor = .white
//        backgroundView.layer.cornerRadius = 13
//        backgroundView.layer.shadowColor = UIColor.black.cgColor
//        backgroundView.layer.shadowOpacity = 0.2
//        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        self.contentView.layer
//            .masksToBounds = true
       self.contentView.addSubview(backgroundView)
        backgroundView.adjustToArea()
    let anotherView = VerticalStack(spacing: 28) {
            VerticalStack(spacing: 0) {
                categoryLabel
                placeLabel
            }
            VerticalStack(spacing: 8) {
            
                fromDistanceLabel
                HorizontalStack {
                    Space()
                    thumbnailView.size(width: 117)
                }.size(height: 83)
                
            }
        }
        backgroundView.adjustToArea()
        backgroundView.addSubview(anotherView)
        anotherView.adjustToArea()
        
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 1, height: 10)
        
        
    }
}


class AnotherPlaceViewController: UIViewController {
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = .init(top: 10, left: 0, bottom: 10, right: 0)
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
        collectionView.register(AnotherPlaceCell.self)
    }
    
}

extension AnotherPlaceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as AnotherPlaceCell
        return cell
    }

}


extension AnotherPlaceViewController: UICollectionViewDelegate {
    
}



extension AnotherPlaceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 140, height: 200)
    }
}
