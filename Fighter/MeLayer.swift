//
//  MeLayer.swift
//  Fighter
//
//  Created by Ryan on 2017/3/16.
//  Copyright © 2017年 Atomax. All rights reserved.
//

import UIKit

class MeLayer: CALayer {
    
    var isHit : Bool = false

    override init(layer: Any) {
     
        super.init(layer: layer);
        
    }
    
    override init() {
        super.init()
        
        let meImage = UIImage(named: "me")
        
        self.contents = meImage?.cgImage;
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
