//
//  SlideViewController.swift
//  xllive
//
//  Created by xiaoyuan on 2016/11/26.
//  Copyright © 2016年 XunLei. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var viewControllers: [UIViewController]? {
        didSet {
            didSetViewControllers()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .horizontal
        let colletionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.showsVerticalScrollIndicator = false
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.decelerationRate = 0.5
        colletionView.isPagingEnabled = true
        colletionView.backgroundColor = UIColor.clear
        colletionView.bounces = false
        return colletionView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK:- private method
    private func didSetViewControllers() {
        for (idx, viewController) in viewControllers!.enumerated() {
            addSubController(viewController)
            collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "UICollectionViewCell\(idx)")
        }
    }
    
    private func addSubController(_ subvc: UIViewController) {
        subvc.willMove(toParentViewController: self)
        addChildViewController(subvc)
        subvc.didMove(toParentViewController: self)
    }
    
    
    private func setUp() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = viewControllers?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell\(indexPath.item)", for: indexPath)
        if cell.contentView.subviews.count == 0 {
            let view = viewControllers![indexPath.item].view!
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: view.bounds.size.height)
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
