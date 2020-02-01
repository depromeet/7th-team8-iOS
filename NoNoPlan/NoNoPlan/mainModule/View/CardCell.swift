//
//  CardCell.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2019/12/29.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit

protocol Expandable {
    func collapse()
    func expand(in collectionView: UICollectionView)
}

extension CardCell: ReusableView, NibLoadableView {}
class CardCell: UICollectionViewCell {
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    let bgBackView = UIView()
    let bgImageView = UIImageView()
    let emptyView = UIView()
    let cardView = CardView()
    private var initialFrame: CGRect?
    private var initialCornerRadius: CGFloat?
    
    let imageView: UIImageView =  {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
       // width.constant = bounds.size.width - 20
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
       // bgBackView.addSubview(bgImageView)
        contentView.addSubview(bgBackView)
       // contentView.addSubview(emptyView)
        
        bgBackView.frame = CGRect(x: 0, y: 0, width: kScreenW - 20, height: GlobalConstants.todayCardSize.height)
        bgBackView.addSubview(cardView)
       
        //imageView.image = UIImage(named: "Card")
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 13
        cardView.layer.masksToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bgBackView.layer.shadowColor = UIColor.black.cgColor
        bgBackView.layer.shadowOpacity = 0.2
        bgBackView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cardView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 20).isActive = true

    }
    
}


enum GlobalConstants {
    static let leftMargin: CGFloat = 20
    
    static let toDayCardRowH: CGFloat = 440
    static let toDayCardCornerRadius: CGFloat = 15.0
    static let todayCardSize: CGSize = CGSize(width: kScreenW - 2 * 20, height: 410)
 
    static let cardDetailTopImageH: CGFloat = 500
    
    static let iconBorderColor: CGColor = UIColor(red: 239/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1).cgColor
    static let iconBorderWidth: CGFloat = 0.8
    static let iconCornerRadius: CGFloat = 17.5
    
    static let textBlueColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)   //007AFF
    static let speratorLineColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
    
    //GameTableViewController
    static let recommandHeight: CGFloat = 336
    static let topicHeight: CGFloat = 282
    static let linkHeight: CGFloat = 312
    static let sectionHeaderH: CGFloat = 42
    static let linkCellHeight: CGFloat = 45
    
    //DetailViewController
    static let detailPreviewImageH: CGFloat = 155
    
    //DownloadViewController
    static let doubleClickViewW: CGFloat = 140
    static let clickBarWidth: CGFloat = 6
}


let kScreenH = UIScreen.main.bounds.size.height
let kScreenW = UIScreen.main.bounds.size.width
let statusBarH = UIApplication.shared.statusBarFrame.height
let navigationBarH: CGFloat = 44
let tabbarExtraH: CGFloat = hasTopNotch() ? 34 : 0
var keyWindow: UIWindow {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.first { $0.isKeyWindow }!
    } else {
        return UIApplication.shared.keyWindow!
    }
}



func hasTopNotch()-> Bool {
    if #available(iOS 11.0, *) {
        let top = UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
        return top < CGFloat(24) ? false : true
    } else {
        return false
    }
}

/// delay action
func delay(_ timeInterval: TimeInterval, closure: @escaping()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval) {
        closure()
    }
}
