//
//  GameContainerView.swift
//  PinBoard
//
//  Created by 叶夏云 on 2019/6/11.
//  Copyright © 2019 叶夏云. All rights reserved.
//

import UIKit

class GameContainerView: UIView {

    var backgroundImageView:UIImageView!
    var whenLayoustSubviews:(()->Void)!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    override func layoutSubviews() {
        super.layoutSubviews()
      
        whenLayoustSubviews()
        
    }
}
