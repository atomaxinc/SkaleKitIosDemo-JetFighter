//
//  EnemyLayer.swift
//  Fighter
//
//  Created by Ryan on 2017/3/16.
//  Copyright © 2017年 Atomax. All rights reserved.
//

import UIKit

class EnemyLayer: CALayer {
    
    override init(layer: Any) {
        
        super.init(layer: layer);
        
    }
    
    override init() {
        super.init()
        
        
        self.bounds = CGRect(x: 0, y: 0, width: 60, height: 15);
        
        let image = UIImage(named: "enemy");
        
        self.contents = image?.cgImage;
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
