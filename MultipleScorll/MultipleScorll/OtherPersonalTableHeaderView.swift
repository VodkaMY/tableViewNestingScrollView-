//
//  OtherPersonalTableHeaderView.swift
//  xllive
//
//  Created by xiaoyuan on 2016/11/28.
//  Copyright © 2016年 XunLei. All rights reserved.
//

import UIKit

protocol OtherPersonalTableHeaderViewDelegate: NSObjectProtocol {
    func action(type: OtherPersonalTableHeaderView.Action, sender: UIButton?)
}

class OtherPersonalTableHeaderView: UIView {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var liveCodeLabel: UILabel!
    @IBOutlet weak var attentionButton: UIButton!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var topSectionView: UIView!
    @IBOutlet weak var topSectionConstraint: NSLayoutConstraint!
    
    weak var delegate: OtherPersonalTableHeaderViewDelegate?

    enum Action: Int {
        case back = 1,saddle, popularity, popularityLine, level
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let blur = UIBlurEffect(style: .light)
        let effview = UIVisualEffectView(effect: blur)
        backgroundImageView.addSubview(effview)
        effview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let cornerRadius = leftButton.bounds.width / 2
        leftButton.layer.cornerRadius = cornerRadius
        leftButton.layer.masksToBounds = true
        
        rightButton.layer.cornerRadius = cornerRadius
        rightButton.layer.masksToBounds = true
        
        centerButton.layer.cornerRadius = cornerRadius
        centerButton.layer.masksToBounds = true
        
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.shadowColor = UIColor.lightGray.cgColor
        avatarImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        avatarImageView.layer.shadowOpacity = 0.6
        avatarImageView.layer.shadowRadius = 2
        avatarImageView.layer.masksToBounds = true
        
        attentionButton.setTitle("+关注", for: .normal)
        attentionButton.setTitleColor(UIColor.white, for: .normal)
        
        attentionButton.setBackgroundImage(UIImage(named: "me_attention_hilight"), for: .selected)
        attentionButton.setTitle("已关注", for: .selected)
        attentionButton.layer.cornerRadius = 2.5
        attentionButton.layer.masksToBounds = true
    }
    
    class func createView() -> OtherPersonalTableHeaderView {
        let view = Bundle.main.loadNibNamed("OtherPersonalTableHeaderView", owner: self, options: nil)?.first as! OtherPersonalTableHeaderView
        return view
    }
    
    @objc private func saddleAction() {
        delegate?.action(type: .saddle, sender: nil)
    }
    
    @objc private func levelAction() {
        delegate?.action(type: .level, sender: nil)
    }
    
    @IBAction private func backAction() {
        delegate?.action(type: .back, sender: nil)
    }
    
    @IBAction private func popularityLineAction() {
        delegate?.action(type: .popularityLine, sender: nil)
    }
    
    
    @IBAction private func popularityAction(_ sender: UIButton) {
        delegate?.action(type: .popularity, sender: sender)
    }
}
