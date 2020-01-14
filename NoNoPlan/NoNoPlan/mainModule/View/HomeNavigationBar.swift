//
//  HomeNavigationBar.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/14.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit


class HomeNavigationBar: UIView {
    
    var logoImageView: UIImageView = {
       let logo = UIImageView(frame: .zero)
        logo.backgroundColor = .red
        return logo
    }()
    var searchButton: UIButton = {
        let search = UIButton(type: .custom)
        search.backgroundColor = .blue
        return search
    }()
    var myInfoButton: UIButton = {
       let myInfo = UIButton(type: .custom)
        myInfo.backgroundColor = .green
        return myInfo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.heightAnchor.constraint(equalToConstant: 144).isActive = true
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        myInfoButton.translatesAutoresizingMaskIntoConstraints = false
        myInfoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        myInfoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        HorizontalStack {
            logoImageView
            searchButton
            myInfoButton
            
        }
        
    }

}
