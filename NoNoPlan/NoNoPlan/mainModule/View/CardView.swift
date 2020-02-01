//
//  CardView.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/24.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit


class CardView: UIView {
    
    let categoryLabel: UILabel  = {
        let categoty = UILabel()
        categoty.numberOfLines = 0
        categoty.textColor = .purple
        categoty.text = "이탙리안"
        
        categoty.font = UIFont.systemFont(ofSize: 13)
        return categoty
    }()
    
    let favoriteButton: UIButton = {
        let favorite = UIButton(type: .custom)
        favorite.backgroundColor = .red
        favorite.setImage(UIImage(named: "bookmark_off"), for: .normal)
        return favorite
    }()
    
    let placeLabel: UILabel = {
        let place = UILabel(frame: .zero)
        place.text = "섭지코지 섭지코지 섭지코지 섭지코지"
        place.lineBreakMode = .byWordWrapping
        place.numberOfLines = 2
        place.font = UIFont.boldSystemFont(ofSize: 30)
        return place
    }()
    
    let evaluationScoreLabel: UILabel = {
       let evaluationScore = UILabel()
        evaluationScore.textColor = UIColor(r: 95, g: 95, b: 95)
        evaluationScore.font = UIFont.boldSystemFont(ofSize: 13)
        evaluationScore.text = "4.3"
        return evaluationScore
    }()
    
    let reviewCountLasbel: UILabel = {
       let review = UILabel()
        review.text = "리뷰 7건"
        review.textColor = UIColor(r: 95, g: 95, b: 95)
        review.font = UIFont.boldSystemFont(ofSize: 13)
        return review
    }()
    
    let explanationLabel: UILabel = {
        let explanation = UILabel(frame: .zero)
        explanation.text = "코의 끄트리 모양처럼 비죽 튀어나온 것으로 서귀포시 성산읍 신양리 해안에 돌출되어 있는 지형"
        explanation.numberOfLines = 2
        explanation.textColor = UIColor(r: 122, g: 122, b: 122)
        explanation.font = UIFont.systemFont(ofSize: 13)
        return explanation
    }()
    
    let thumbnailView: UIImageView = {
       let thumbnail = UIImageView(image: UIImage(named: "Card"))
        return thumbnail
    }()

    let fromDistanceLabel: UILabel = {
        let fromDistance = UILabel()
        fromDistance.text = "내 위치에서 15km"
        fromDistance.textColor = UIColor(r: 122, g: 122, b: 122)
        fromDistance.font = UIFont.systemFont(ofSize: 13)
        return fromDistance
    }()
    let evaluationView = EvaluationView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        evaluationView.setEvaluation(3)
       // reviewCountLasbel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        //categoryLabel.sizeToFit()
        let category = HorizontalStack(alignment: .bottom) {
            categoryLabel
            Space()
            favoriteButton.size(width: 26).size(height: 32)
            Space().size(width: 20)
        }

        let content = VerticalStack(spacing : 16) {
            VerticalStack(spacing: 24) {

                VerticalStack(spacing: 12) {
                    VerticalStack(spacing: 8) {
                        category.size(height: 32)
                        HorizontalStack {
                            placeLabel
                            Space().size(width: 50)
                        }
                        
                    }
                    explanationLabel
                    HorizontalStack(spacing: 6) {
                        evaluationView.size(height: 12)
                        evaluationScoreLabel
                        reviewCountLasbel
                        Space()
                    }

                }
                HorizontalStack {
                    Space()
                    thumbnailView.size(height: 177).size(width: 247)
                }
            }
            HorizontalStack {
                Space()
                fromDistanceLabel
            }.padding(.trailing, 20)
        }
        .padding(.leading, 20)
        .padding(.top, 20)
        .padding(.bottom, 24)
        
        
       // let content = UIImageView(image:  UIImage(named: "Card"))
        
        addSubview(content)
        content.adjustToArea()
    }
}
