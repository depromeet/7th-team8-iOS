//
//  MenuController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/04.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit

extension MenuCell: ReusableView, NibLoadableView {}

class MenuCell: UICollectionViewCell {
    let label: UILabel = {
        let l = UILabel()
        l.text = "menuItem"
        l.textAlignment = .center
        l.textColor = .black
       
        return l
    }()
   //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuView: UIView {
    
    fileprivate let menuItems = ["News", "Home", "popluarssssss"]
     let menuBar: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = .white
         collectionView.register(MenuCell.self)
         
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
             layout.scrollDirection = .horizontal
             layout.minimumLineSpacing = 0
             layout.minimumInteritemSpacing = 0
         }
        
         self.addSubview(menuBar)
         
         menuBar.anchor(nil, self.leadingAnchor, self.bottomAnchor, nil, size: .init(width: 0, height: 5))
         
         let width = menuItems.first!.size(withAttributes:[.font: UIFont.systemFont(ofSize:17.0)])
         
         menuBar.widthAnchor.constraint(equalToConstant: width.width + 20).isActive = true
        self.collectionView(self.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
        
        collectionView.reloadData()
        print(collectionView.indexPathsForSelectedItems)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
        
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MenuCell
        cell.label.text = menuItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = menuItems[indexPath.row]
        let width = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:17.0)])
        return .init(width: width.width + 20, height: self.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

class MenuController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    fileprivate let menuItems = ["News", "Home", "popluarssssss","home"]
     let menuBar: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MenuCell.self)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
        }
       
        view.addSubview(menuBar)
        
        menuBar.anchor(nil, view.leadingAnchor, view.bottomAnchor, nil, size: .init(width: 0, height: 5))
        
        let width = menuItems.first!.size(withAttributes:[.font: UIFont.systemFont(ofSize:17.0)])
        
        menuBar.widthAnchor.constraint(equalToConstant: width.width + 20).isActive = true
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
        self.collectionView(self.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
                      print(collectionView.indexPathsForSelectedItems)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MenuCell
        cell.label.text = menuItems[indexPath.row]
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = menuItems[indexPath.row]
        let width = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:17.0)])
        return .init(width: width.width + 20, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
