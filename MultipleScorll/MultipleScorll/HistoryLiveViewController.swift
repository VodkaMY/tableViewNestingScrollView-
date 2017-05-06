//
//  HistoryLiveViewController.swift
//  xllive
//
//  Created by xiaoyuan on 2016/11/26.
//  Copyright © 2016年 XunLei. All rights reserved.
//

import UIKit

class HistoryLiveViewController: UIViewController, PersonalProtocol {
    internal var didScroll: ((CGFloat) -> ())?


    //MARK: property
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        return tb
    }()
    
    var scroller: UIScrollView {
        return tableView
    }
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: private method
    func registerCell() {
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
    }
    
    func setUpViews() {
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {[weak self] (make) in
            if let v = self?.view {
                make.edges.equalTo(v).inset(UIEdgeInsets.zero)
            }
        }
    }
}

extension HistoryLiveViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView.contentOffset.y)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.black
        return cell
    }
}

