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
        logo.image = UIImage(named: "app_logo")
        logo.backgroundColor = .white
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    var searchButton: UIButton = {
        let search = UIButton(type: .custom)
        search.setImage(UIImage(named: "search"), for: .normal)
        return search
    }()
    var myInfoButton: UIButton = {
       let myInfo = UIButton(type: .custom)
        myInfo.setImage(UIImage(named: "profile"), for: .normal)
        return myInfo
    }()
    lazy var components: [UIView] = {
        
        return [logoImageView, searchButton, myInfoButton]
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
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
        self.backgroundColor = .white
        let view =  HorizontalStack(spacing: 13) {
            logoArea()
            searchArea().size(width: 40)
            profileArea().size(width: 40)
            
        }.padding(.leading, 18)
        .padding(.trailing, 18)
        
        self.addSubview(view)
        view.adjustToArea()
            
    }

    
    func logoArea() -> UIView {
        let backView = UIView()
        backView.addSubview(logoImageView)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        return backView
        
    }
    
    
    func profileArea() -> UIView {
     let backView = UIView()
            backView.addSubview(myInfoButton)
        myInfoButton.translatesAutoresizingMaskIntoConstraints = false
        myInfoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        myInfoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myInfoButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor).isActive = true
         myInfoButton.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20).isActive = true
        return backView
        
    }
    
    func searchArea() -> UIView {
        let backView = UIView()
        backView.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20).isActive = true
        return backView
        
    }
    
}
