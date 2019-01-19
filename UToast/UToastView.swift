//
//  UToastView.swift
//  UToastDemo
//
//  Created by wen on 2019/1/19.
//  Copyright © 2019 wenfeng. All rights reserved.
//

import UIKit

public enum UToastViewType {
    case info
    case success
    case warn
    case error
}

open class UToastView: UIView {
    public var label: UILabel!
    public var insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    public var originY: CGFloat = 0
    public var distance: CGFloat = 24
    public var interval: TimeInterval = 0.2
    public var duration: TimeInterval = 2
    public var colors: [UToastViewType: (background: UIColor, text: UIColor)] = [
        .info: (UIColor(red: 230/255, green: 247/255, blue: 255/255, alpha: 1), UIColor(red: 24/255, green: 144/255, blue: 255/255, alpha: 1)),
        .success: (UIColor(red: 246/255, green: 255/255, blue: 237/255, alpha: 1), UIColor(red: 82/255, green: 196/255, blue: 26/255, alpha: 1)),
        .warn: (UIColor(red: 255/255, green: 251/255, blue: 230/255, alpha: 1), UIColor(red: 250/255, green: 173/255, blue: 20/255, alpha: 1)),
        .error: (UIColor(red: 255/255, green: 241/255, blue: 240/255, alpha: 1), UIColor(red: 245/255, green: 34/255, blue: 45/255, alpha: 1))
    ]
    
    public override init(frame: CGRect) {
        let height = frame.height == 0 ? 36 : frame.height
        super.init(frame: CGRect(x: 0, y: frame.minY, width: frame.width, height: height))
        
        originY = frame.minY
        
        isHidden = true
        
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        layer.opacity = 0
        
        label = UILabel()
        addSubview(label)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        
        let centerY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: insets.left)
        let trailing = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -insets.right)
        label.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([centerY, leading, trailing])
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func render(message: String, type: UToastViewType = .info, duration: TimeInterval? = nil) {
        let width = UToastView.getTextWidth(text: message, font: label.font) + insets.left + insets.right
        frame = CGRect(x: (superview!.frame.width - width) / 2, y: originY, width: width, height: frame.height)
        
        backgroundColor = colors[type]?.background
        label.textColor = colors[type]?.text
        label.text = message
        
        isHidden = false
        UIView.animate(withDuration: interval) {
            self.layer.opacity = 1
            self.frame = CGRect(x: self.frame.minX, y: self.originY + self.distance, width: self.frame.width, height: self.frame.height)
        }
        
        let d = duration ?? self.duration
        if d > 0 {
            UToastView.setTimeout(d) {
                UIView.animate(withDuration: self.interval, animations: {
                    self.layer.opacity = 0
                    self.frame = CGRect(x: self.frame.minX, y: self.originY, width: self.frame.width, height: self.frame.height)
                }, completion: { (_) in
                    self.isHidden = true
                    self.removeFromSuperview()
                })
            }
        }
    }
    
    private static func getTextWidth(text: String, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    private static func setTimeout(_ interval: TimeInterval, block:@escaping () -> Void) {
        Timer.scheduledTimer(timeInterval: interval, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
}
