//
//  ViewController.swift
//  UToastDemo
//
//  Created by wen on 2019/1/19.
//  Copyright © 2019 wenfeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: (view.frame.width - 160) / 2, y: 400, width: 160, height: 32))
        view.addSubview(button)
        button.setTitle("Display Info Toast", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handle), for: .touchUpInside)
        
        let buttonError = UIButton(frame: CGRect(x: (view.frame.width - 160) / 2, y: 460, width: 160, height: 32))
        view.addSubview(buttonError)
        buttonError.setTitle("Display Error Toast", for: .normal)
        buttonError.setTitleColor(.black, for: .normal)
        buttonError.addTarget(self, action: #selector(handleError), for: .touchUpInside)
    }
    
    @objc func handle() {
        view.utoast(message: "This is a toast message. Longgggggggggggggggggggggggg", y: 88)
    }
    
    @objc func handleError() {
        view.utoast(message: "Something wrong!", y: 88, type: .error)
    }

}

