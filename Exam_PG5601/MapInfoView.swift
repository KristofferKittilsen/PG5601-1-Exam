//
//  MapInfoView.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 04/11/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import UIKit

@IBDesignable
class MapInfoView: UIView {
    var view: UIView!
    
    @IBOutlet weak var lon: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
        self.view = view
    }
    
}
