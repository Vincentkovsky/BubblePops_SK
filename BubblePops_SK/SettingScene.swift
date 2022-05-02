//
//  settingScene.swift
//  BubblePops_SK
//
//  Created by Vincent Jin on 2022/4/28.
//

import Foundation
import SpriteKit
import UIKit



class SettingScene: SKScene{
    let defaults = UserDefaults.standard
    var numberSlider: UISlider!
    var timerSlider: UISlider!
    let numbers = SKLabelNode(fontNamed:  "Pusab")
    let timer = SKLabelNode(fontNamed:  "Pusab")
    
    
    

    

    let click = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
  

    override func didMove(to view: SKView) {
        
        numberSlider = UISlider(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height*0.38 ,width: 320 ,height: 40))
        self.view!.addSubview(numberSlider)
        
        numberSlider.minimumValue = 1
        numberSlider.maximumValue = 30
        
        if defaults.object(forKey: "numberOfBubbles") != nil {
        numberSlider.value = defaults.float(forKey: "numberOfBubbles")
        }else{
            numberSlider.value = 15
        }
        numberSlider.thumbTintColor = UIColor.orange
        numberSlider.minimumTrackTintColor = UIColor.orange
        numberSlider.maximumTrackTintColor = UIColor.white
        numberSlider.addTarget(self, action: #selector(self.numberSliderValueDidChange(_:)), for: .valueChanged)
//        UIView.animate(withDuration: 0.8) {
//            self.numberSlider.setValue(15, animated: true)
//       }

        self.view!.addSubview(numberSlider)

        
        timerSlider = UISlider(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height*0.68 ,width: 320 ,height: 40))
        self.view!.addSubview(timerSlider)
        
        timerSlider.minimumValue = 3
        timerSlider.maximumValue = 300
        
        if defaults.object(forKey: "timerSettingVal") != nil {
            timerSlider.value = defaults.float(forKey: "timerSettingVal")
        }else{
            timerSlider.value = 60
        }
        timerSlider.thumbTintColor = UIColor.orange
        timerSlider.minimumTrackTintColor = UIColor.orange
        timerSlider.maximumTrackTintColor = UIColor.white
        timerSlider.addTarget(self, action: #selector(self.timerSliderValueDidChange(_:)), for: .valueChanged)

        self.view!.addSubview(timerSlider)
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let back = SKLabelNode(fontNamed:  "Pusab")
        back.text = "Back"
        back.fontSize = 60
        back.fontColor = SKColor.orange
        back.zPosition = 1
        back.name = "backButton"
        back.position = CGPoint(x: self.size.width*0.3, y: self.size.height*0.9)
        self.addChild(back)
        
        numbers.text = "Number of bubbles: \(Int(numberSlider.value))"
        numbers.fontSize = 45
        numbers.fontColor = SKColor.orange
        numbers.zPosition = 1
        numbers.position = CGPoint(x: self.size.width/2, y: self.size.height*0.7)
        self.addChild(numbers)
        
        
        
        
        
        
        timer.text = "Timer setting: \(Int(timerSlider.value)) Seconds"
        timer.fontSize = 45
        timer.fontColor = SKColor.orange
        timer.zPosition = 1
        timer.position = CGPoint(x: self.size.width/2, y: self.size.height*0.4)
        self.addChild(timer)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let tappedNode = atPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            
            
            if tappedNodeName == "backButton"{
                self.run(click)
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                numberSlider.removeFromSuperview()
                timerSlider.removeFromSuperview()
                
            }
            
            
        }
    }
    
    @objc func numberSliderValueDidChange(_ sender:UISlider!)
    {
//        let roundedStepValue = round(sender.value / step) * step
//        sender.value = roundedStepValue
        numbers.text = "Number of bubbles: \(Int(numberSlider.value))"
        defaults.set(numberSlider.value, forKey: "numberOfBubbles")

        
    }
    
    @objc func timerSliderValueDidChange(_ sender:UISlider!)
    {
//        let roundedStepValue = round(sender.value / step) * step
//        sender.value = roundedStepValue
//        self.numberSlider.setValue(timerSlider.value, animated: true)
        timer.text = "Timer setting: \(Int(timerSlider.value)) Seconds"
        defaults.set(timerSlider.value, forKey: "timerSettingVal")


    }
    
}
