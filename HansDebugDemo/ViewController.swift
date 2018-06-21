//
//  ViewController.swift
//  HansDebugDemo
//
//  Created by chinaSoft on 2018/6/21.
//  Copyright © 2018 chinaSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController,DotzuXBubbleDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.gray
        WindowHelper.shared.enable()
        WindowHelper.shared.vc.bubble.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didTapDotzuXBubble(){
        if(WindowHelper.shared.isShowing){
            return
        }
        let dVC = DebugViewController()
        WindowHelper.shared.isShowing = true
        let nav = UINavigationController(rootViewController: dVC)
        self.present(nav, animated: true) {
            
        }
    }

}

