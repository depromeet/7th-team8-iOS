//
//  ReviewViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/02/08.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit

extension ReviewCell: ReusableView, NibLoadableView {}
class ReviewCell: UICollectionViewCell {
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    let contentLabel: UILabel = {
       let content = UILabel()
        content.text = "그들의 장식하는 소담스러운 고행을 부패를 능히 인류의 사람은 무엇을 있는가? 주며, 자신과 얼마나 청춘에서만 그들에게 뛰노는 봄바람이다. 이상 위하여 싸인 놀이...그들의 장식하는 소담스러운 고행을 부패를 능히 인류의 사람은 무엇을 있는가? 주며, 자신과 얼마나 청춘에서만 그들에게 뛰노는 봄바람이다. 이상 위하여 싸인 놀이..."
        content.numberOfLines = 0
        content.font = UIFont.systemFont(ofSize: 13)
        return content
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "닉네임"
        title.font = UIFont.boldSystemFont(ofSize: 13)
        return title
    }()
    
    let profileImageView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "Card")
        profile.layer.cornerRadius = 32 / 2
        profile.layer.masksToBounds = true
        return profile
    }()
    
    let registerDateLabel: UILabel = {
        let register = UILabel()
        register.text = "2020-01-18"
        register.font = UIFont.systemFont(ofSize: 13)
        return register
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        HorizontalStack {
            Space().size(width: 20)
            VerticalStack(spacing: 10) {
             HorizontalStack(spacing: 10) {
                 profileImageView.size(width: 32)
                 VerticalStack {
                     titleLabel
                     registerDateLabel
                 }
             }.size(height: 32)
                
                VerticalStack {
                    
                    contentLabel
                    Text("더보기")
                }.padding(.leading, 42)
                    .padding(.trailing, 20)
                
                
                
                
                
            }
           
            
        }.build(on: self.contentView)
        self.contentView.layoutIfNeeded()
    }
    
}


class ReviewViewController: UIViewController {
   
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 20
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 1)
        
        return layout
    }()
    
    lazy var collectionView: CustomCollectionView = {
        
        let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        //collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "동백키친"
        collectionView.register(ReviewCell.self)
        view.backgroundColor = UIColor(r: 252, g: 252, b: 252)
        collectionView.backgroundColor = UIColor(r: 252, g: 252, b: 252)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    
    
}



extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ReviewCell
//        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CardCell
//
//        if indexPath.row % 2 == 0 {
//            cell.cardView.placeLabel.text = testText[1]
//        } else {
//            cell.cardView.placeLabel.text = testText[2]
//        }
        cell.layoutIfNeeded()
        return cell
    }

}



