//
//  DetailScrollView.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/28.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit

class DetailScrollView: UIScrollView {
    
   // let bgBackView = UIView()
    let cardView = CardView()
    let textView = UITextView()
    let callButton: UIButton = {
       let call = UIButton()
       
        call.setImage(UIImage(named: "call_btn"), for: .normal)
        return call
    }()
    let locationButton: UIButton = {
       let location = UIButton()
        
        location.setImage(UIImage(named: "map_btn"), for: .normal)
        return location
    }()

    let onTheWayLabel: UILabel = {
       let ontheWay = UILabel()
        ontheWay.font = UIFont.boldSystemFont(ofSize: 13)
        ontheWay.text = "가는길"
        return ontheWay
    }()
    let onTheWayDetailLabel: UILabel = {
        let ontheWayDetail = UILabel()
        ontheWayDetail.font = UIFont.boldSystemFont(ofSize: 13)
        ontheWayDetail.text = "가는길"
        return ontheWayDetail
    }()
    
    let businessHoursLabel: UILabel = {
        let businessHours = UILabel()
        businessHours.font = UIFont.boldSystemFont(ofSize: 13)
        businessHours.text = "영업시간"
        return businessHours
    }()
    
    let businessHoursDetailLabel: UILabel = {
        let businessHoursDetail = UILabel()
        businessHoursDetail.font = UIFont.boldSystemFont(ofSize: 13)
        businessHoursDetail.text = "영업시간"
        return businessHoursDetail
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
      //  self.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
      
         
        cardView.isUserInteractionEnabled = true
        let v0 = UIView()
        let v = UIView()
               v.backgroundColor = .red
        let v1 = bottomArea()
            
            
        
       // v0.addSubview(v1)
        //v1.adjustToArea()
        
        
       
       
          VerticalStack {
            cardView.size(width: kScreenW)
            v1.size(width: kScreenW)
            Space().size(height: 55)
        }.build(on: self)
    
        let v3 = UIView()
       

    }
    
    func bottomArea() -> UIView {
        let t =  Text("dkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;ldsadkdkdksdkas;ldksa;;")
        t.numberOfLines = 0
        return HorizontalStack {
            Space().size(width: 20)
            VerticalStack {
                HorizontalStack(spacing: 18) {
                    callButton.size(width: 40)
                    locationButton.size(width: 40)
                    Space()
                }.size(height: 40)
                Space().size(height: 24)
                VerticalStack(spacing: 42) {
                    VerticalStack(spacing: 16) {
                        VerticalStack(spacing: 16) {
                            textArea(title: "가는길", content: "제주특별자치도 제주시 한림읍 수원7길 42 (우)63023")
                            textArea(title: "영업시간", content: "월,화,수,금,토,일 11:00 ~ 20:00\n월,화,수,금 브레이크타임 15:00 ~ 16:00")
                            textArea(title: "상세정보", content: "제주맛집, 활전복 해물탕, 활전복뚝배기, 전복죽, 조림, 구이전문, SBS방영 맛집<12.04.29>\n\n아침식사 예약시 9시가능\n*예약필수 입니다")
                        }.padding(.trailing, 25)
                        Space(color: .blue).size(height: 100)
                        reviewArea()
                    }
                }
     
            }
        }
    }
    
    
    func textArea(title: String, content: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.text = title
        
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 13)
        contentLabel.text = content
        
        return VerticalStack(spacing: 4) {
            titleLabel
            contentLabel
        }
    }
    
    
    
    
    var reviewButton: UIButton = {
       let review = UIButton()
        review.setTitle("리뷰작성하기", for: .normal)
        review.backgroundColor = UIColor(r: 241, g: 241, b: 241)
        review.layer.cornerRadius = 4
        review.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
       
        review.setTitleColor(.black, for:.normal)
        review.titleEdgeInsets = UIEdgeInsets(top: 12, left: 26, bottom: 12, right: 26)
        return review
    }()
    
    func reviewArea() -> UIView {
        let backView = UIView()
        
        return VerticalStack(spacing: 42) {
            HorizontalStack(spacing: 1) {
                reviewClickArea()
                Space().size(width: 19)
            }
                
            
            Space(color: .red).size(height: 200)
            anotherPlace()
        }
        
        
    }
    
    
    func reviewClickArea() -> UIView {
        let questionLabel = UILabel()
        questionLabel.text = "동백키친에 다녀오셨나요?"
        questionLabel.font = UIFont.systemFont(ofSize: 20)
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 13
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.2
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 1)
        let reviewStack = VerticalStack(spacing: 12) {
            questionLabel
            HorizontalStack {
                reviewButton.size(width: 128)
                Space()
            }.size(height: 40)
            
            
        }.padding(.leading, 20)
        .padding(.top, 20)
        .padding(.trailing, 20)
        .padding(.bottom, 20)
        
        backgroundView.addSubview(reviewStack)
        
        reviewStack.adjustToArea()
        return backgroundView
    }
    
    
    func anotherPlace() -> UIView {
        
        let label = UILabel()
        label.text = "다른 추천 장소"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return VerticalStack(spacing: 18) {
            label
            Space(color: .green).size(height: 195)
        }
    }
    
    
}
