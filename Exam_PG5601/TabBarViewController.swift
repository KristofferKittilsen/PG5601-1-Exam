//
//  TabBarViewController.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 27/10/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import UIKit

enum TabbarItemTag: Int {
    case firstViewController = 101
    case secondViewController = 102
}

class TabBarViewController: UITabBarController {
    var firstTabbarItemImageView: UIImageView!
    var secondTabbarItemImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstItemView = tabBar.subviews.first!
        firstTabbarItemImageView = firstItemView.subviews.first as? UIImageView
        firstTabbarItemImageView.contentMode = .center
        
        let secondItemView = self.tabBar.subviews[1]
        self.secondTabbarItemImageView = secondItemView.subviews.first as? UIImageView
        self.secondTabbarItemImageView.contentMode = .center
    }
    
    private func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        })
    }

}
