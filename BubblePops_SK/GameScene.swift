//
//  GameScene.swift
//  BubblePops_SK
//
//  Created by Vincent Jin on 2022/4/28.
//


//Requirements below all complete
//Still need to control the number of bubbles on the scrren at a time
//Need APIs to adjust the timer frame and the number of bubbles
//need to have more color of bubbles add(maybe better images)
//maybe change to better sound effects
//probability of bubbles
//Colour Game Points Probability of Appearance
//Red 1 40%
//Pink 2 30%
//Green 5 15%
//Blue 8 10%
//Black 10 5%

////The app shall refresh bubbles displayed every game second. That is, after every game
//second, the app shall randomly remove a number of bubbles (do not include the bubbles
//that have been popped by the player) and replace them with another set of randomly
//positioned bubbles. There may be more or less bubbles on the screen compared with the
//previous game second subjected to the restrictions in 5 and 6. In this case, "random"
//means chosen by the program, not the user. So you have a lot of bubbleretion in
//placement of new bubbles and selection of old bubbles.

////When the game stops, the player’s score shall be saved in a persistent file (or database)
//that contains all players’ names and their highest scores.



import SpriteKit
import GameplayKit
var scoreNumber = 0
var leaderDict = [String : Int]()

var lastTappedColor: String = " "

class GameScene: SKScene {
    
//    var leaderboardDict = [String: Int]()


    let defaults = UserDefaults.standard
//    let leaderboardDefaults = UserDefaults.standard
    let scoreLabel = SKLabelNode(fontNamed: "Pusab")
    let timerLabel=SKLabelNode(fontNamed: "Pusab")
    
    var timer:Timer = Timer()
    
    lazy var count:Int = Int(defaults.float(forKey: "timerSettingVal"))

    
    let playCorrect = SKAction.playSoundFileNamed("Correct.wav", waitForCompletion: false)
    let playOver = SKAction.playSoundFileNamed("GameOverSound.wav", waitForCompletion: false)
    
    let gameArea: CGRect
    
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 19.5/9.0
        let playableWidth = size.height / maxAspectRatio
        let gameAreMargin = (size.width - playableWidth)/2
        gameArea = CGRect(x: gameAreMargin, y: 0, width: playableWidth, height:  size.height)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random()*(max - min) + min
    }
    
    override func didMove(to view: SKView) {
        
//        leaderboardDict = defaults.object(forKey: "leaderboardDict") as! [String : Int]
        if( Int(defaults.float(forKey: "timerSettingVal")) == 0){
            count = 60
        }
        
        scoreNumber = 0
        
//        createSceneContents()
//
//        var splinePoints = [CGPoint(x: 0, y: 0),
//                            CGPoint(x: 0, y: self.size.height),
//                            CGPoint(x: self.size.width, y: 0),
//                            CGPoint(x: self.size.width, y: self.size.height)]
//        let ground = SKShapeNode(splinePoints: &splinePoints,
//                                 count: splinePoints.count)
//        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
//        ground.physicsBody?.restitution = 0.75
//
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
//        let bubble = SKSpriteNode(imageNamed: "bubble2")
//        bubble.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
//        bubble.zPosition = 2
//        bubble.name = "bubbleObject"
//        self.addChild(bubble)
        
        
        scoreLabel.fontSize = 120
        scoreLabel.text = "Score: 0"
        scoreLabel.fontColor = SKColor.white
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        self.addChild(scoreLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        
        timerLabel.fontSize = 80
        timerLabel.text = String(count)
        timerLabel.fontColor = SKColor.white
        timerLabel.zPosition = 1
        timerLabel.position = CGPoint(x: self.size.width*0.3, y: self.size.height*0.1)
        self.addChild(timerLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let positionOfTouch = touch.location(in: self)
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            switch nameOfTappedNode {
            case "redBubble":
                tappedNode.name = ""
                tappedNode.removeAllActions()

                tappedNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
                self.run(playCorrect)
//                generateNewBubbles()
                if lastTappedColor == "redBubble"{
                    scoreNumber += 2
                    generateCombo()
                }else{
                    scoreNumber += 1
                }
                scoreLabel.text = "Score: \(scoreNumber)"
                lastTappedColor = "redBubble"
                break
            case "pinkBubble":
                tappedNode.name = ""
                tappedNode.removeAllActions()

                tappedNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
                self.run(playCorrect)
//                generateNewBubbles()
                if lastTappedColor == "pinkBubble"{
                    scoreNumber += 3
                    generateCombo()

                }else{
                    scoreNumber += 2
                }
                scoreLabel.text = "Score: \(scoreNumber)"
                lastTappedColor = "pinkBubble"
                break
            case "greenBubble":
                tappedNode.name = ""
                tappedNode.removeAllActions()

                tappedNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
                self.run(playCorrect)
//                generateNewBubbles()
                if lastTappedColor == "greenBubble"{
                    scoreNumber += 7
                    generateCombo()
                }else{
                    scoreNumber += 5
                }
                scoreLabel.text = "Score: \(scoreNumber)"
                lastTappedColor = "greenBubble"
                break
            case "blueBubble":
                tappedNode.name = ""
                tappedNode.removeAllActions()

                tappedNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
                self.run(playCorrect)
//                generateNewBubbles()
                if lastTappedColor == "blueBubble"{
                    scoreNumber += 12
                    generateCombo()
                }else{
                    scoreNumber += 8
                }
                scoreLabel.text = "Score: \(scoreNumber)"
                lastTappedColor = "blueBubble"

                break
            case "blackBubble":
                tappedNode.name = ""
                tappedNode.removeAllActions()

                tappedNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
                self.run(playCorrect)
//                generateNewBubbles()
                if lastTappedColor == "blackBubble"{
                    scoreNumber += 15
                    generateCombo()
                }else{
                    scoreNumber += 10
                }
                scoreLabel.text = "Score: \(scoreNumber)"
                lastTappedColor = "blackBubble"

                break
                
            default:
                return
                    
            }
            
            
//            if nameOfTappedNode == "bubbleObject"{
//
//                tappedNode.name = ""
//                tappedNode.removeAllActions()
//
//                tappedNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
//                self.run(playCorrect)
//
//                generateNewBubbles()
//
//
//                scoreNumber += 1
//                scoreLabel.text = "Score: \(scoreNumber)"
//
//            }
        }
    }
    
    func generateCombo(){
        let comboLabel = SKLabelNode(fontNamed: "Pusab")
        comboLabel.fontSize = 80
        comboLabel.text = "Combo"
        comboLabel.fontColor = SKColor.cyan
        comboLabel.zPosition = 1
        comboLabel.position = CGPoint(x: self.size.width*0.65, y: self.size.height*0.1)
        self.addChild(comboLabel)
        comboLabel.run(SKAction.fadeOut(withDuration: 1))
        comboLabel.run(SKAction.scale(to: 0, duration: 1))
//        comboLabel.removeFromParent()
    }
    
    func generateNewBubbles(){
        
        var randomImageNumber: Int
        let randomNumber = randomPercent()
        switch(randomNumber) {
        case 0..<40:
          randomImageNumber = 2
            break
        case 40..<70:
            randomImageNumber = 5
            break
        case 70..<85:
            randomImageNumber = 4
            break
        case 85..<95:
            randomImageNumber = 1
            break
        case 95..<100:
            randomImageNumber = 3
            break
        default:
            return
        }
//        var randomImageNumber = arc4random_uniform(4)+1
        let bubble = SKSpriteNode(imageNamed: "bubble\(randomImageNumber)")
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: max(bubble.size.width/2, bubble.size.height/2))
        bubble.physicsBody?.usesPreciseCollisionDetection = true

        bubble.zPosition = 2
        
        
        switch randomImageNumber {
        case 1:
            bubble.name="blueBubble"
            break
        case 2:
            bubble.name="redBubble"
            break
        case 3:
            bubble.name="blackBubble"
            break
        case 4:
            bubble.name="greenBubble"
            break
        case 5:
            bubble.name="pinkBubble"
            break
        default:
            return
        }
        
        
        
        let randomX = random(min: gameArea.minX + bubble.size.width/2, max: gameArea.maxX - bubble.size.width/2)
        
        let randomY = random(min: gameArea.minY + bubble.size.height/2, max: gameArea.maxY - bubble.size.height/2)
        
        bubble.position = CGPoint(x: randomX, y: randomY)
        self.addChild(bubble)
        
        bubble.run(SKAction.scale(to: 1.5, duration: 1))
        
        bubble.run(SKAction.fadeOut(withDuration: 1))

//        bubble.run(SKAction.sequence([
//            SKAction.scale(to: 0, duration: 3),
//            playOver,
//            SKAction.run(runGameOver)
//        ]))
        }
//
//    func createSceneContents() {
//        self.backgroundColor = .black
////        self.scaleMode = .aspectFit
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//    }
    
    func runGameOver(){
        //Game over part
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTrasition = SKTransition.fade(withDuration: 1)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTrasition)
//        print(playerName.name)

    }
    func randomPercent() -> Double {
      return Double(arc4random() % 1000) / 10.0;
    }
    
    @objc func timerCounter() -> Void{
         
        var bubbleNumber = defaults.integer(forKey: "numberOfBubbles")
        if bubbleNumber == 0 {
            bubbleNumber = 15
        }
        
        if count <= 5{
            timerLabel.fontColor = SKColor.red
        }
        
        if count > 0{
            
            
            var randomBubbleNumber = arc4random_uniform(UInt32(bubbleNumber)) + 1
            for _ in 1...randomBubbleNumber{
                generateNewBubbles()
            }
            count = count - 1
            timerLabel.text = String(count)
            if leaderDict[playerName.name] == nil{
                leaderDict.updateValue(scoreNumber, forKey: playerName.name)
            }else{
                if(scoreNumber > leaderDict[playerName.name] ?? 0){
                    leaderDict.updateValue(scoreNumber, forKey: playerName.name)
                }
            }
        }
        
        if count == 0{
            self.timer.invalidate()
            self.run(playOver)
            self.run(SKAction.run(runGameOver))
            
//            if leaderboardDict[playerName.name] == nil{
//                leaderboardDict.updateValue(scoreNumber, forKey: playerName.name)
//            }else{
//                if(scoreNumber > leaderboardDict[playerName.name]!){
//                    leaderboardDict.updateValue(scoreNumber, forKey: playerName.name)
//                }
//            }
            
//            if(leaderboardDefaults.object(forKey: playerName.name) == nil){
//                leaderboardDefaults.set(scoreNumber, forKey: playerName.name)
//            }else{
//                if(scoreNumber > leaderboardDefaults.object(forKey: playerName.name) as! Int){
//                    leaderboardDefaults.set(scoreNumber, forKey: playerName.name)
//                }
//            }x
//            let temp = defaults.object(forKey: "leaderboardDict") as! [String: Int]
            
//            if leaderboardDict.count >= temp.count{
//                defaults.set(leaderboardDict, forKey: "leaderboardDict")
//            }
        }
        
    }
   
}
