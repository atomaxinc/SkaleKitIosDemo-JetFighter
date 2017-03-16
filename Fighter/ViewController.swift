//
//  ViewController.swift
//  Fighter
//
//  Created by Ryan on 2017/3/16.
//  Copyright © 2017年 Atomax. All rights reserved.
//

import UIKit
import SkaleKit

class ViewController: UIViewController, SKSkaleDelegate, EnemyEngineDelegate, StartOverViewControllerDelegate {

    var skale : SKSkale = SKSkale();
    
    let enemyEngine : EnemyEngine = EnemyEngine();
    
    let me = MeLayer();
    
    
    
    func skaleWeightToPosition(weight : Float32) -> CGFloat
    {
        let pos = self.view.bounds.height - CGFloat(weight/2000)*self.view.bounds.height;
        
        return pos;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.skale.delegate = self;
        
        self.me.frame = CGRect(x: 20, y: self.view.bounds.height-60, width: 80, height: 40);
        
        self.view.layer.addSublayer(self.me);
        
        self.enemyEngine.range = self.view.bounds.height;
        self.enemyEngine.window = self.view.bounds.width;

        self.enemyEngine.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "toStartOver"
        {
            let startOverViewController = segue.destination as! StartOverViewController
            
            startOverViewController.delegate = self;

        }
     }
    
    
    func clearSublayers()
    {
        for sublayer in self.view.layer.sublayers! {
            if sublayer is EnemyLayer
            {
                sublayer.removeFromSuperlayer()
            }
        }
    }

    
    
    func skaleDidConnected(_ skale: SKSkale!)
    {
    
        print("\n did connect");
        
        if self.enemyEngine.isStarted == false
        {
            self.enemyEngine.startAttck();

        }
        
    }
    
    func skaleDidDisconnected(_ skale: SKSkale!)
    {
        if self.enemyEngine.isStarted == true
        {
            self.enemyEngine.stop()
        }
    }
    
    func skale(_ skale: SKSkale!, didErrorOccur error: Error!)
    {
    
    }
    
    func skaleWeightDidUpdate(_ weight: Float32)
    {
        if self.me.isHit == false
        {
            let pos = self.skaleWeightToPosition(weight: weight);
            
            self.me.position = CGPoint(x: self.me.position.x, y: pos);
        }
    }

    
    
    
    // Mark : Enemy
    
    func didFireEnemy(enemyLayer : CALayer)
    {
        self.view.layer.addSublayer(enemyLayer);
        
        if self.enemyEngine.detectHitTartget(targetLayer: self.me)
        {
            self.enemyEngine.stop()
            
            self.me.isHit = true;
            
            print("\n hit target");
            
            
            self.performSegue(withIdentifier: "toStartOver", sender: nil)
            
            
        }
    }
    
    
    func didClickStartOverButton(_ viewController : StartOverViewController)
    {
        viewController.dismiss(animated: true) { 
            
            
            self.enemyEngine.stop();
            self.enemyEngine.clearEnemies();
            self.clearSublayers()
            
            self.me.isHit = false;
            
            if !self.enemyEngine.isStarted && self.skale.isConnected
            {
                self.enemyEngine.startAttck();
            }
            
            
        }
    
    }
    

}

