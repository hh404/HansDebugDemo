//
//  DebugViewController.swift
//  DemoXCConfig
//
//  Created by hans on 2018/6/20.
//  Copyright © 2018年 Tomasz Szulc. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DebugViewController: ButtonBarPagerTabStripViewController {
    var isReload = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.groupTableViewBackground
        let btn = UIButton(frame: CGRect(x: 0, y: 64, width: 32, height: 32))
        btn.setImage(UIImage(named:"close"), for: .normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(disMiss), for: .touchUpInside)
        
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = .orange
        //-
        super.viewDidLoad()
        
        buttonBarView.removeFromSuperview()
        navigationController?.navigationBar.barTintColor = UIColor(red: 129/255.0, green: 212/255.0, blue: 38/255.0, alpha: 1)
        navigationController?.navigationBar.addSubview(buttonBarView)
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .black
            newCell?.label.textColor = .red
            
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            } else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    @objc func disMiss() {
        self.dismiss(animated: true) {
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        WindowHelper.shared.isShowing = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_3 = DebugDetailViewController(style: .grouped, itemInfo: "E01")
        let child_5 = DebugDetailViewController(style: .plain, itemInfo: "E02")
        let child_7 = DebugDetailViewController(style: .grouped, itemInfo: "E03")

        
        guard isReload else {
            return [child_3, child_5, child_7]
        }
        
        var childViewControllers = [child_3, child_5, child_7]
        
        for index in childViewControllers.indices {
            let nElements = childViewControllers.count - index
            let n = (Int(arc4random()) % nElements) + index
            if n != index {
                childViewControllers.swapAt(index, n)
            }
        }
        let nItems = 1 + (arc4random() % 8)
        return Array(childViewControllers.prefix(Int(nItems)))
    }
    
    override func reloadPagerTabStripView() {
        isReload = true
        if arc4random() % 2 == 0 {
            pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        } else {
            pagerBehaviour = .common(skipIntermediateViewControllers: arc4random() % 2 == 0)
        }
        super.reloadPagerTabStripView()
    }
    
    override func configureCell(_ cell: ButtonBarViewCell, indicatorInfo: IndicatorInfo) {
        super.configureCell(cell, indicatorInfo: indicatorInfo)
        cell.backgroundColor = .clear
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
