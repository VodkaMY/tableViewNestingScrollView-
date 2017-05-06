//
//  MultipleTouchTableView.swift
//  xllive
//
//  Created by xiaoyuan on 2016/12/16.
//  Copyright © 2016年 XunLei. All rights reserved.
//

import UIKit

class MultipleTouchTableView: UITableView, UIGestureRecognizerDelegate {

    var ignoreGestures = [UIGestureRecognizer]()
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        for gesture in ignoreGestures {
            if otherGestureRecognizer == gesture {
                return false
            }
        }
        return true
    }
}
