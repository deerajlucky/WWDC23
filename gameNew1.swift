import SpriteKit
import PlaygroundSupport

class GameScene: SKScene {
    
    let catNode = SKSpriteNode(imageNamed: "cat")
    let fishNode = SKSpriteNode(imageNamed: "fish")
    let labelNode = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
    let backgroundNode = SKSpriteNode(imageNamed: "background")
    var score = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(backgroundNode)
        
        catNode.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        catNode.setScale(0.5)
        addChild(catNode)
        
        fishNode.position = CGPoint(x: frame.midX + 50, y: frame.midY + 100)
        fishNode.setScale(0.3)
        addChild(fishNode)
        
        labelNode.text = "Score: \(score)"
        labelNode.fontSize = 24
        labelNode.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        addChild(labelNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let moveAction = SKAction.move(to: location, duration: 0.5)
            catNode.run(moveAction)
            
            if catNode.intersects(fishNode) {
                score += 1
                labelNode.text = "Score: \(score)"
                fishNode.removeFromParent()
                
                let newFishNode = SKSpriteNode(imageNamed: "fish")
                newFishNode.position = CGPoint(x: CGFloat.random(in: 50...frame.maxX - 50), y: CGFloat.random(in: 50...frame.maxY - 50))
                newFishNode.setScale(0.3)
                addChild(newFishNode)
                
                let scaleAction = SKAction.scale(to: 0.5, duration: 0.1)
                let rotateAction = SKAction.rotate(byAngle: CGFloat.pi, duration: 0.5)
                let groupAction = SKAction.group([scaleAction, rotateAction])
                catNode.run(groupAction)
            }
        }
    }
}

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
let gameScene = GameScene(size: sceneView.bounds.size)
gameScene.scaleMode = .aspectFill
sceneView.presentScene(gameScene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
