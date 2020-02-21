//
//  ReviewWritingViewController.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/02/22.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit
import Cosmos
class ReviewWritingViewController: UIViewController, UITextViewDelegate {
    
    
    var titleString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = titleString
        
        let questionLabel = UILabel()
        questionLabel.text = "방문한 장소를 평가해주세요!"
        questionLabel.font = UIFont.systemFont(ofSize: 13)
        questionLabel.sizeToFit()
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(questionLabel)
        questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        questionLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 35).isActive = true
        
        let ratingView = CosmosView()
        ratingView.settings.filledImage = UIImage(named: "big_star_on")
        ratingView.settings.emptyImage = UIImage(named: "big_star_off")
        ratingView.settings.starSize = 40
        ratingView.settings.starMargin = 8
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingView)
        ratingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ratingView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,constant: 11).isActive = true
        
        let divider = UIView()
        divider.backgroundColor = UIColor(r: 215, g: 215, b: 215)
        divider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(divider)
        divider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        divider.widthAnchor.constraint(equalToConstant: view.frame.width  - 40).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.topAnchor.constraint(equalTo: ratingView.bottomAnchor,constant: 40).isActive = true
        
        let textView = UITextView()
        textView.delegate = self
        textView.text = "\(titleString) 다녀온 경험을 공유해주세요. (500자 이내)"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: view.frame.width  - 40).isActive = true
       
        textView.topAnchor.constraint(equalTo: divider.bottomAnchor,constant: 9).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 9).isActive = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {

            textView.text = "\(titleString) 다녀온 경험을 공유해주세요. (500자 이내)"
            textView.textColor = UIColor.lightGray
        }
    }
}
