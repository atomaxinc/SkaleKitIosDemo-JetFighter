//
//  EnemyEngine.swift
//  Fighter
//
//  Created by Ryan on 2017/3/16.
//  Copyright © 2017年 Atomax. All rights reserved.
//

import UIKit
import AVFoundation

protocol EnemyEngineDelegate
{
    func didFireEnemy(enemyLayer : CALayer);
    
}

enum Level
{
    case L1
    case L2
    case L3
    case L4
    case L5
}

class EnemyEngine: NSObject {

    var fireTimer : Timer?
    var moveTimer : Timer?

    var range : CGFloat?
    var enemies = [CALayer]();
    var window : CGFloat?
    
    var player : AVAudioPlayer?;
    
    var delegate : EnemyEngineDelegate?
    
    var isStarted = false;

    
    override init()
    {
        super.init()
        
    }
    
    init(range : CGFloat)
    {
        super.init()
        self.range = range;
    }
    
    func clearEnemies()
    {
        self.enemies.removeAll()
    }
    
    func startAttck() {
        
        self.fireTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(fire), userInfo: nil, repeats: true);
        self.moveTimer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(move), userInfo: nil, repeats: true);

        self.isStarted = true
    }
    
    func stop()
    {
        self.fireTimer?.invalidate();
        self.moveTimer?.invalidate();
        
        self.isStarted = false


    }
    
    func fire()
    {
        guard  let range = self.range, let window = self.window else {
            return
        }
        
        let randomPOS : UInt32 = arc4random_uniform(UInt32(range)) // range is 0 to 99
        
        let layer = EnemyLayer();
        
        //layer.backgroundColor = UIColor.blue.cgColor;
        
        layer.position = CGPoint(x: window + 40, y: CGFloat(randomPOS));

        
        self.enemies.append(layer);
        
        self.delegate?.didFireEnemy(enemyLayer: layer);
        
        
    }
    
    
    func detectHitTartget(targetLayer : CALayer) -> Bool
    {
        for layer in self.enemies
        {
            let enemyFrame = CGRect(x: layer.frame.origin.x, y: layer.frame.origin.y, width: layer.frame.size.width - 8, height: layer.frame.size.height - 4)
            
            let targetFrame = CGRect(x: targetLayer.frame.origin.x, y: targetLayer.frame.origin.y, width: targetLayer.frame.size.width - 8, height: targetLayer.frame.size.height - 4)

            //if layer.frame.intersects(targetLayer.frame)
            if (enemyFrame.intersects(targetFrame))
            {
                playSound();
                
                return true;
            }
        }
        
        return false;
    }
    
    func move()
    {
        let pastEnemies = self.enemies.filter { (layer) -> Bool in
            
            return layer.position.x < -40;
        }
        
        for layer in pastEnemies
        {
            layer.removeFromSuperlayer();
            
            self.enemies.remove(at: self.enemies.index(of: layer)!);
        }
    
        
        for layer in self.enemies {
            
            let x = layer.position.x - 3;
            
            layer.position = CGPoint(x: x, y: layer.position.y);
        }
    }
    
    
    func playSound()
    {
        let url = Bundle.main.url(forResource: "SoundEffect", withExtension: "mp3")!
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            
            guard let player = self.player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
 
 
}
