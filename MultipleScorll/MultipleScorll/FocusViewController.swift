//
//  FocusViewController.swift
//  xllive
//
//  Created by xiaoyuan on 2016/11/25.
//  Copyright © 2016年 XunLei. All rights reserved.
//

import UIKit

class FocusViewController: UIViewController, PersonalProtocol{
    internal var didScroll: ((CGFloat) -> ())?

    
    //MARK:- property
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorColor = UIColor.clear
        return tb
    }()
    
    var scroller: UIScrollView {
        return tableView
    }
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK:- private method
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

extension FocusViewController : UITableViewDelegate, UITableViewDataSource {
    //MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView.contentOffset.y)
    }
    
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
}
