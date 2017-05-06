//
//  PersonalCenterManager.swift
//  xllive
//
//  Created by xiaoyuan on 2016/11/28.
//  Copyright © 2016年 XunLei. All rights reserved.
//

import UIKit

class PersonalCenterManager : NSObject {
    
    enum PersonalModule: Int {
        case live = 1, focus, fans
    }
    
    class func create(module: PersonalModule) -> UIViewController {
        var vc: UIViewController!
        switch module {
            case .live:
                vc = HistoryLiveViewController()
            case .focus:
                vc = FocusViewController()
            case .fans:
                vc = FansViewController()
        }
        return vc
    }
    
    class func personalModuleViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        viewControllers.append(create(module: .live))
        viewControllers.append(create(module: .focus))
        viewControllers.append(create(module: .fans))
        return viewControllers
    }
    
    class func personalCenterController() -> UIViewController {
        let other = OtherPersonalCenterViewController()
        return other
    }
}

protocol PersonalProtocol: NSObjectProtocol {
    var scroller: UIScrollView { get }
    var didScroll: ((_ offset:CGFloat) -> ())? { get  set }
}

