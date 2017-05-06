//
//  PersonalSectionHeaderView.swift
//  xllive
//
//  Created by xiaoyuan on 2016/12/1.
//  Copyright © 2016年 XunLei. All rights reserved.
//

import UIKit

class PersonalSectionHeaderView: UITableViewHeaderFooterView {
    
    struct Item {
        var count: Int
        var title: String
        
        mutating func update(count: Int) {
            self.count = count
        }
    }
    
    class ItemView: UIControl {
        lazy var countLable: UILabel = {
            let l = UILabel()
            l.font = UIFont.systemFont(ofSize: 16)
            return l
        }()
        
        lazy var hitLable: UILabel = {
            let l = UILabel()
            l.font = UIFont.systemFont(ofSize: 10)
            return l
        }()
        
        var item: Item! {
            didSet {
                countLable.text = "\(item.count)"
                hitLable.text = item.title
            }
        }
        
        init() {
            super.init(frame: CGRect.zero)
            addSubview(countLable)
            addSubview(hitLable)
            countLable.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-9)
            }
            hitLable.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(9)
            }
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            let point = touch?.location(in: self)
            print("\(point)")
            if bounds.contains(point!) {
                sendActions(for: .touchUpInside)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        class func create(item: Item) -> ItemView {
            let view = ItemView()
            view.item = item
            return view
        }
        
        func mark(_ mark: Bool) {
            if mark {
                countLable.textColor = UIColor.red
                hitLable.textColor = UIColor.red
            } else {
                countLable.textColor = UIColor.black
                hitLable.textColor = UIColor.black
            }
        }
        
        func updateItem(count: Int) {
            countLable.text = "\(count)"
            item.update(count: count)
        }
    }
    
    var items: [Item]! {
        didSet {
            _ = subviews.map {
                $0.removeFromSuperview()
            }
            _ = items.map {
                let itemView = ItemView.create(item: $0)
                itemView.addTarget(self, action: #selector(itemAction(sender:)), for: .touchUpInside)
                addSubview(itemView)
                itemViews.append(itemView)
            }
        }
    }
    
    var delegate: PersonalSectionHeaderViewDelegate?
    var itemViews = [ItemView]()
    private var cindex = 0
    var index: Int {
        return cindex
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpViews()
    }
    
    @objc private func itemAction(sender: ItemView) {
        let newIndex = itemViews.index(of: sender)!
        if index == newIndex {
            delegate?.personalSectionHeaderView(self, selectSameItemView: itemViews[index], selectIndex: index)
            return
        }
        let itemView = itemViews[index]
        itemView.mark(false)
        sender.mark(true)
        cindex = newIndex
        delegate?.personalSectionHeaderView(self, selectItemView: sender, selectIndex: newIndex)
    }
    
    func setIndex(_ index: Int) {
        if index == cindex, index < items.count { return }
        let sender = itemViews[index]
        let itemView = itemViews[cindex]
        itemView.mark(false)
        sender.mark(true)
        cindex = index
    }
    
    func setUpViews() {
        if items.count > 1 {
            let size = CGSize(width: bounds.width / CGFloat(items.count), height: bounds.height)
            var pre:ItemView!
            for (idx, itemView) in itemViews.enumerated() {
                itemView.mark(idx == index)
                switch idx {
                case 0:
                    itemView.snp.makeConstraints({ (make) in
                        make.left.equalToSuperview()
                        make.top.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.size.equalTo(size)
                    })
                case 1..<items.count:
                    itemView.snp.makeConstraints({ (make) in
                        make.left.equalTo(pre.snp.right)
                        make.top.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.size.equalTo(pre.snp.size)
                    })
                case items.count:
                    itemView.snp.makeConstraints({ [weak self] (make) in
                        if let _ = self {
                            make.left.equalTo(pre.snp.right)
                            make.top.equalToSuperview()
                            make.bottom.equalToSuperview()
                            make.right.equalTo(self!.snp.right)
                            make.size.equalTo(pre.snp.size)
                        }
                    })
                default:
                    break
                }
                pre = itemView
            }
        }
    }
}

protocol PersonalSectionHeaderViewDelegate {
    func personalSectionHeaderView(_ headerView: PersonalSectionHeaderView, selectItemView itemView:PersonalSectionHeaderView.ItemView, selectIndex index: Int)
    func personalSectionHeaderView(_ headerView: PersonalSectionHeaderView, selectSameItemView itemView:PersonalSectionHeaderView.ItemView, selectIndex index: Int)
}
