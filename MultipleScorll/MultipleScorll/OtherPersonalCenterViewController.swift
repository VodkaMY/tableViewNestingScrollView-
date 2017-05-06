//
//  OtherPersonalCenterViewController.swift
//  xllive
//
//  Created by xiaoyuan on 2016/11/28.
//  Copyright © 2016年 XunLei. All rights reserved.
//

import UIKit

class OtherPersonalCenterViewController: UIViewController {
    
    //MARK: property
    lazy var tableView: MultipleTouchTableView = {
        let tb = MultipleTouchTableView(frame: CGRect.zero, style: .plain)
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorColor = UIColor.clear
        tb.bounces = false
        return tb
    }()
    
    var personalSectionHeaderView: PersonalSectionHeaderView?
    
    let slideViewController = SlideViewController()
    var tableHeaderView = OtherPersonalTableHeaderView.createView()
    
    
    var offset: CGFloat = 0
    var chlidOffset: CGFloat = 0
    
    let reuserIdentifier = "PersonalSectionHeaderView"
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    deinit {
        slideViewController.collectionView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    //MARK:- private method
    private func setUp() {
        edgesForExtendedLayout = []
        view.addSubview(tableView)
        update()
        tableHeaderView.delegate = self
        tableView.tableHeaderView = tableHeaderView
        tableView.register(PersonalSectionHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: reuserIdentifier)
        tableHeaderView.snp.makeConstraints {[weak self] (make) in
            if let s = self {
                make.left.equalToSuperview()
                make.right.equalTo(s.view.snp.right)
                make.top.equalTo(s.view.snp.top)
                make.height.equalTo(283)
            }
        }
        tableView.tableFooterView = UIView()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUpSlideViewController() {
        slideViewController.collectionView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        let vcs = PersonalCenterManager.personalModuleViewControllers()
        slideViewController.viewControllers = vcs
        for vc in vcs {
            if let v = vc as? PersonalProtocol {
                v.scroller.bounces = false
                v.didScroll = { [weak v, weak self] offset in
                    if let s = self {
                        if s.offset < CGFloat(219) {
                            v?.scroller.contentOffset = CGPoint(x: 0, y: 0)
                        }else {
                            s.chlidOffset = offset
                        }
                    }
                }
            }
        }
        tableView.ignoreGestures.append(slideViewController.collectionView.panGestureRecognizer)
    }
    
    
    private func update() {
        setUpSlideViewController()
        tableView.reloadData()
    }
    
}

extension OtherPersonalCenterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        slideViewController.willMove(toParentViewController: self)
        let v = slideViewController.view!
        cell.contentView.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addChildViewController(slideViewController)
        slideViewController.didMove(toParentViewController: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height - 64 - 65
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuserIdentifier) as? PersonalSectionHeaderView
        view?.delegate = self
        let item0 = PersonalSectionHeaderView.Item(count: 0, title: "直播")
        let item2 = PersonalSectionHeaderView.Item(count: 0, title: "关注")
        let item3 = PersonalSectionHeaderView.Item(count: 0, title: "粉丝")
        view?.items = [item0, item2, item3]
        personalSectionHeaderView = view
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if chlidOffset == 0 {
            offset = scrollView.contentOffset.y
            if scrollView.contentOffset.y <= 219 {
                let y = scrollView.contentOffset.y
                tableHeaderView.snp.updateConstraints({[weak self] (make) in
                    if let s = self {
                        make.top.equalTo(s.view.snp.top).offset(-y)
                    }
                })
                tableHeaderView.topSectionConstraint.constant = y
                tableHeaderView.topSectionView.backgroundColor = UIColor.white.withAlphaComponent(y / 78.0)
                tableHeaderView.titleLable.alpha = (y - 78) >= 0 ? 1 : 0
            } else {
                scrollView.contentOffset = CGPoint(x: 0, y: 219)
            }
        } else {
            scrollView.contentOffset = CGPoint(x: 0, y: 219)
        }
    }
}

extension OtherPersonalCenterViewController: OtherPersonalTableHeaderViewDelegate, PersonalSectionHeaderViewDelegate {
    //MARK:- OtherPersonalTableHeaderViewDelegate
    func action(type: OtherPersonalTableHeaderView.Action, sender: UIButton?) {
        switch type {
        case .back:
            goback()
        case .saddle:
            goSaddlePage()
        case .popularity:
            popularity(sender: sender!)
        case .popularityLine:
            popularityLine()
        case .level:
            goLevelPage()
        }
    }
    
    func goback() {
        
    }
    
    func goSaddlePage() {
        
    }
    
    func goLevelPage() {
        
    }
    
    func popularity(sender: UIButton) {
        
    }
    
    func popularityLine() {
        
    }
    
    //MARK:- PersonalSectionHeaderViewDelegate
    func personalSectionHeaderView(_ headerView: PersonalSectionHeaderView, selectItemView itemView: PersonalSectionHeaderView.ItemView, selectIndex index: Int) {
        slideViewController.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        if let s = slideViewController.viewControllers?[index] as? PersonalProtocol {
            chlidOffset = s.scroller.contentOffset.y
        }
    }
    
    func personalSectionHeaderView(_ headerView: PersonalSectionHeaderView, selectSameItemView itemView: PersonalSectionHeaderView.ItemView, selectIndex index: Int) {
        if let s = slideViewController.viewControllers?[index] as? PersonalProtocol {
            s.scroller.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    //MARK:- KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if "contentOffset" == keyPath {
            let newVaule = change?[.newKey]
            if context == nil {
                if let v = newVaule as? CGPoint {
                    let index = Int(v.x / view.bounds.width)
                    let sectionView = tableView.headerView(forSection: 0) as? PersonalSectionHeaderView
                    if let view = sectionView {
                        view.setIndex(index)
                        if let s = slideViewController.viewControllers?[index] as? PersonalProtocol {
                            chlidOffset = s.scroller.contentOffset.y
                        }
                    }
                }
            }
        }
    }
}
