//
//  GameOverScene.swift
//  BubblePops_SK
//
//  Created by Vincent Jin on 2022/4/28.
//
//At the end of the game, a high score board shall be displayed with the names and scores
//of the highest ranking players. (See Figure 2)

import Foundation
import SpriteKit


class GameOverScene: SKScene, UITableViewDelegate, UITableViewDataSource{
    
    let items = leaderDict.sorted { (first, second) -> Bool in
        return first.value > second.value
    }
    
    let tableView = UITableView()
    let click = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        
        
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let gameOVerLabel = SKLabelNode(fontNamed: "Pusab")
        gameOVerLabel.text = "Game Over!"
        gameOVerLabel.fontSize = 110
        gameOVerLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        gameOVerLabel.fontColor = SKColor.white
        gameOVerLabel.zPosition = 1
        self.addChild(gameOVerLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "Pusab")
        scoreLabel.text = "Score: \(scoreNumber)"
        scoreLabel.fontSize = 70
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.8)
        scoreLabel.fontColor = SKColor.lightGray
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        let leaderLabel = SKLabelNode(fontNamed: "Pusab")
        leaderLabel.text = "Leaderboard"
        leaderLabel.fontSize = 75
        leaderLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.7)
        leaderLabel.name = "leaderboardButton"
        leaderLabel.fontColor = SKColor.orange
        leaderLabel.zPosition = 1
        self.addChild(leaderLabel)
        
        
        let tempImageView = UIImageView(image: UIImage(named: "Background"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;
        
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        self.view?.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        tableView.frame=CGRect(x: (UIScreen.main.bounds.size.width*0.5 - 175),y: (UIScreen.main.bounds.size.height*0.5 - 150), width:350 ,height:300)
        view.addSubview(tableView)
        tableView.reloadData()

        
        
        
        let replayLabel = SKLabelNode(fontNamed: "Pusab")
        replayLabel.text = "Replay"
        replayLabel.fontSize = 75
        replayLabel.fontColor = SKColor.orange
        replayLabel.zPosition = 1
        replayLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.15)
        replayLabel.name = "replayButton"
        self.addChild(replayLabel)
        
        let exitLabel = SKLabelNode(fontNamed: "Pusab")
        exitLabel.text = "Exit"
        exitLabel.fontSize = 75
        exitLabel.fontColor = SKColor.lightGray
        exitLabel.zPosition = 1
        exitLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.05)
        exitLabel.name = "exitButton"
        self.addChild(exitLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let tappedNode = atPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            
            
            if tappedNodeName == "replayButton"{
                self.run(click)
                tableView.removeFromSuperview()

                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)

                
            }
            
            if tappedNodeName == "exitButton"{
                self.run(click)
                tableView.removeFromSuperview()

                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)

            }
            
            if tappedNodeName == "leaderboardButton"{
                self.run(click)

//                GameViewController?.performSegue(withIdentifier: "leaderboardSegue", sender: nil)

//                let sceneToMoveTo = MainMenuScene(size: self.size)
//                sceneToMoveTo.scaleMode = self.scaleMode
//                let sceneTransition = SKTransition.fade(withDuration: 0.5)
//                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        customCell.backgroundView = UIImageView.init(image: UIImage.init(named: "Background"))
//        customCell.textLabel?.text = "    \(self.items[indexPath.row].key)"
        customCell.configure(with: "\(self.items[indexPath.row].value)", with: "\(self.items[indexPath.row].key)")
        return customCell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension Dictionary{
    subscript(i:Int) -> (key:Key, value: Value){
        get{
            return self[index(startIndex, offsetBy: i)]
        }
    }
}
