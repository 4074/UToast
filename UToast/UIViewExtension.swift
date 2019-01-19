//
//  UIViewExtension.swift
//  UToastDemo
//
//  Created by wen on 2019/1/20.
//  Copyright © 2019 wenfeng. All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult
    public func utoast(message: String, y: CGFloat = 0, type: UToastViewType = .info, duration: TimeInterval? = nil) -> UToastView {
        
        let toast = UToastView(frame: CGRect(x: 0, y: y, width: frame.width, height: 0))
        addSubview(toast)
        toast.render(message: message, type: type, duration: duration)
        
        return toast
    }
}

