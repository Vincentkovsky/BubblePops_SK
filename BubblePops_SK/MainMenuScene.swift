//
//  MainMenuScene.swift
//  BubblePops_SK
//
//  Created by Vincent Jin on 2022/4/28.
//

import Foundation
import SpriteKit

struct playerName {
     static var name = ""
}

class MainMenuScene: SKScene{
    
    weak var GameViewController: UIViewController?
    let defaults = UserDefaults.standard

    let click = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
    var nameText: UITextField!
    


    override func didMove(to view: SKView) {
        
//        nameText.background = UIImage(named: "Background.png")
////        nameText.layer.borderColor = clear
//        nameText.layer.borderWidth = 0


//        nameText.background  = UIImage(named: "Background")

        
        nameText = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 20,width: 320 ,height: 40))


        self.view!.addSubview(nameText)

//        highScoreText.delegate = self
    
//        highScoreText.borderStyle = UITextField.BorderStyle.roundedRectroundedRect
        nameText.textColor = SKColor.black
        nameText.font = UIFont(name: "Pusab", size: 18)
        nameText.textAlignment = .center
        nameText.placeholder = "Enter your name here"
        nameText.backgroundColor = SKColor.white
        nameText.autocorrectionType = UITextAutocorrectionType.yes
       
        nameText.clearButtonMode = UITextField.ViewMode.whileEditing
        nameText.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        
//        nameText.addTarget(self, action: #selector(self.nameTextChanged(_:)), for: .valueChanged)
        self.view!.addSubview(nameText)
        
        
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        

        let titleLabel1 = SKLabelNode(fontNamed:  "Pusab")
        titleLabel1.text = "Bubble"
        titleLabel1.fontSize = 90
        titleLabel1.fontColor = SKColor.systemPink
        titleLabel1.zPosition = 1
        titleLabel1.position = CGPoint(x: self.size.width/2, y: self.size.height*0.8)
        self.addChild(titleLabel1)
        
        let titleLabel2 = SKLabelNode(fontNamed:  "Pusab")
        titleLabel2.text = "Pops"
        titleLabel2.fontSize = 200
        titleLabel2.fontColor = SKColor.cyan
        titleLabel2.zPosition = 1
        titleLabel2.position = CGPoint(x: self.size.width/2, y: self.size.height*0.7)
        self.addChild(titleLabel2)
        
        let author = SKLabelNode(fontNamed: "Pusab")
        author.text = "Presented by Wenzheng Jin"
        author.fontSize = 37
        author.fontColor = SKColor.lightGray
        author.zPosition = 1
        author.position = CGPoint(x: self.size.width/2, y: self.size.height*0.9)
        self.addChild(author)
        
        let nameField = SKLabelNode(fontNamed: "Pusab")
        nameField.text = "Enter your name below"
        nameField.fontSize = 37
        nameField.fontColor = SKColor.orange
        nameField.zPosition = 1
        nameField.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        self.addChild(nameField)
        
        let playLabel = SKLabelNode(fontNamed: "Pusab")
        playLabel.text = "Play"
        playLabel.fontSize = 150
        playLabel.fontColor = SKColor.orange
        playLabel.zPosition = 1
        playLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.35)
        playLabel.name = "playButton"
        self.addChild(playLabel)
        
        let settingsLabel = SKLabelNode(fontNamed: "Pusab")
        settingsLabel.text = "Settings"
        settingsLabel.fontSize = 100
        settingsLabel.fontColor = SKColor.lightGray
        settingsLabel.zPosition = 1
        settingsLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.25)
        settingsLabel.name = "settingsButton"
        self.addChild(settingsLabel)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let tappedNode = atPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            
            
            if tappedNodeName == "playButton"{
                playerName.name = nameText.text ?? "Default Player"
                self.run(click)
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                
                nameText.removeFromSuperview()
               

            }
            
            if tappedNodeName == "settingsButton"{
                self.run(click)
                let sceneToMoveTo = SettingScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                
                nameText.removeFromSuperview()

            }
            
            
        }
    }
    
//
//    @objc func nameTextChanged(_ sender:UITextField!)
//    {
////        let roundedStepValue = round(sender.value / step) * step
////        sender.value = roundedStepValue
////        self.numberSlider.setValue(timerSlider.value, animated: true)
//
////        timer.text = "Timer setting: \(Int(timerSlider.value)) Seconds"
//        playerName.name = nameText.text ?? "SSS"
//    }
}
