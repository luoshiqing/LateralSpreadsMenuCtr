//
//  UIView+Extension.swift
//  LeftNav
//
//  Created by sqluo on 2017/3/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

extension UIView {
    
    //获取该视图的 控制器
    func parentViewController() -> UIViewController? {
        
        if self.next is UIViewController{
            return self.next as? UIViewController
        }
        
        let next = self.superview
        
        while (next != nil) {
            let nextResponder: UIResponder? = next!.next
            if nextResponder is UIViewController{
                return nextResponder as? UIViewController
            }
        }
        //如果没有父视图，则返回 根控制器
        return UIApplication.shared.keyWindow?.rootViewController
    }
}
