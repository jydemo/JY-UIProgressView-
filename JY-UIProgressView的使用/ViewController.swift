//
//  ViewController.swift
//  JY-UIProgressView的使用
//
//  Created by atom on 2017/4/8.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var myTimer: Timer?
    fileprivate var count = 0
    fileprivate let complete = 100
    fileprivate let fullScreenrSize = UIScreen.main.bounds.size
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(myProgressView)
        self.view.addSubview(myActivityIndicator)
        self.view.addSubview(myButton)
        clickButton()
    }
    
    private lazy var myProgressView: UIProgressView = {
        let myProgressView = UIProgressView(progressViewStyle: .default)
        myProgressView.progressTintColor = UIColor.gray
        myProgressView.trackTintColor = UIColor.orange
        myProgressView.backgroundColor = UIColor.black
        return myProgressView
    }()
    
    private lazy var myActivityIndicator: UIActivityIndicatorView = {
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        myActivityIndicator.color = UIColor.blue
        myActivityIndicator.backgroundColor = UIColor.white
        return myActivityIndicator
    }()
    
    private lazy var myButton: UIButton = {
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        myButton.setTitle("Reset", for: .normal)
        myButton.backgroundColor = UIColor.blue
        myButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return myButton
    }()
    
    override func viewDidLayoutSubviews() {
        myProgressView.frame = CGRect(x: 0, y: 0, width: fullScreenrSize.width * 0.8, height: 50)
        myProgressView.center = CGPoint(x: fullScreenrSize.width * 0.5, y: fullScreenrSize.height * 0.2)
        myActivityIndicator.center = CGPoint(x: fullScreenrSize.width * 0.5, y: fullScreenrSize.height * 0.4)
        myButton.center = CGPoint(x: fullScreenrSize.width * 0.5, y: fullScreenrSize.height * 0.65)
    }
    
    @objc private func clickButton() {
        myButton.isEnabled = false
        myProgressView.progress = 0
        myActivityIndicator.startAnimating()
        myTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showProgress(sender:)), userInfo: ["test": "test"], repeats: true)
    }
    
    @objc private func showProgress(sender: Timer) {
        count += 5
        myProgressView.progress = Float(count) / Float(complete)
        if count >= complete {
            var info = sender.userInfo as? [String: Any]
            print("\(String(describing: info?["test"]))")
            count = 0
            myTimer?.invalidate()
            myTimer = nil
            myActivityIndicator.stopAnimating()
            myButton.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

