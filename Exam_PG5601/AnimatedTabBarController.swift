//
//  AnimatedTabBarController.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 27/10/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import UIKit

class AnimatedTabBarController: UITabBarController {
    
    var secondItemImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let secondItemView = self.tabBar.subviews[1]
        self.secondItemImageView = secondItemView.subviews.first as! UIImageView
        self.secondItemImageView.contentMode = .center
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1 {
            self.secondItemImageView.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut,
                           animations: { () -> Void in
                            
                            let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                            self.secondItemImageView.transform = rotation
            }, completion: nil)
        }
    }

}
