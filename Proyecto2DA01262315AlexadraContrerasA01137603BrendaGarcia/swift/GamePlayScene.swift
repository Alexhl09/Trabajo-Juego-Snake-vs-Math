//
//  GamePlayScene.swift
//  Proyecto2DA01262315AlexadraContrerasA01137603BrendaGarcia
//
//  Created by Alejandro on 06/04/18.
//  Copyright © 2018 AleyBrenda. All rights reserved.
//
import SpriteKit
import GameplayKit
import AudioToolbox
import AVFoundation
struct CuerpoFisico {
    static let cabeza : UInt32 = 0x1 << 0
    static let operacion : UInt32 = 0x1 << 1
    static let cola : UInt32 = 0x1 << 2
    static let respuesta : UInt32 = 0x1 << 3
    static let respuestaCorrecta : UInt32 = 0x1 << 4
}

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    private var cabeza = SKSpriteNode()
    private var respuestaEquivocada : SystemSoundID = 0
    private var respuestaBuena : SystemSoundID = 0
    private var ganas : SystemSoundID = 0
    private var gameOver : SystemSoundID = 0
    private var reproductor : AVAudioPlayer!
    var posicionRespuestaCorrecta = 1
    var resumeB = SKSpriteNode()
    var quitB = SKSpriteNode()
    private var regreso = SKSpriteNode()
    private var pausePanel : SKSpriteNode?
    private var operacionLabel = SKLabelNode()
    private var resupuesta = SKSpriteNode()
    private var resupuesta2 = SKSpriteNode()
    private var textMalaRes2 = SKLabelNode()
    private var resupuesta3 = SKSpriteNode()
    private var textMalaRes3 = SKLabelNode()
    private var resupuesta4 = SKSpriteNode()
    private var textMalaRes4 = SKLabelNode()
    private var fondoOperaciones = SKSpriteNode()
    private var textRespuesta = SKLabelNode()
    private var textMalaRes = SKLabelNode()
    private var cola1 = SKSpriteNode()
    private var cola = [SKSpriteNode()]
    private var numero = [Bool](repeating: false, count: 20)
    private var index = 0
    private var background = SKSpriteNode(imageNamed: "Orange_BG")
    var numeroColas = 0
    var numeroVidas = 1
    private var gana = SKSpriteNode()
    private var pierde = SKSpriteNode()
    private var respuestaCorrecta = SKSpriteNode()
    private var res = ""
    var numero1 = Int()
    var numero2 = Int()
    var animacionTime : Double = 15
    
    func crearCabeza()
    {
        cabeza = self.childNode(withName: "cabeza") as! SKSpriteNode
        cabeza.position = CGPoint(x: 0, y: -200)
        cabeza.setScale(0.5)
        cabeza.zPosition = 2
        cabeza.physicsBody = SKPhysicsBody(rectangleOf: cabeza.size)
        cabeza.physicsBody?.categoryBitMask = CuerpoFisico.cabeza
        cabeza.physicsBody?.collisionBitMask = CuerpoFisico.respuesta | CuerpoFisico.respuestaCorrecta
        cabeza.physicsBody?.contactTestBitMask = CuerpoFisico.respuesta | CuerpoFisico.respuestaCorrecta
        cabeza.physicsBody?.isDynamic = true
        cabeza.physicsBody?.affectedByGravity = false
    }
    func crearOperacion()
    {
        numero1 = GKRandomDistribution(lowestValue: 0, highestValue: 99).nextInt()
        numero2 = GKRandomDistribution(lowestValue: 0, highestValue: 99).nextInt()
        
        var string = "\(numero1) + \(numero2)"
        operacionLabel.text = string
        operacionLabel.fontSize =  90
        operacionLabel.position = CGPoint(x: 0, y: 400)
        operacionLabel.fontName = "Arial-BoldMT"
        operacionLabel.physicsBody?.isDynamic = false
        operacionLabel.physicsBody?.affectedByGravity = false
        operacionLabel.zPosition = 3
        addChild(operacionLabel)
        fondoOperaciones = self.childNode(withName: "fondoOperacion") as! SKSpriteNode
        fondoOperaciones.position = CGPoint(x: operacionLabel.position.x, y: operacionLabel.position.y + 28)
        fondoOperaciones.physicsBody?.isDynamic = false
        fondoOperaciones.physicsBody?.affectedByGravity = false
   
        
    }
    func crearCola()
    {
        
        cola1 = SKSpriteNode(imageNamed: "cuerpo_snake")
        
        switch numeroColas {
        case 15:
            cola1.position = CGPoint(x: 0, y:-700 )
            break
        case 0:
            cola1.position = CGPoint(x: cabeza.position.x, y:-280 )
            break
        case 1:
            cola1.position = CGPoint(x: 0, y:-310 )
            break
        case 2:
            cola1.position = CGPoint(x: 0, y:-340 )
            break
        case 3:
            cola1.position = CGPoint(x: 0, y:-370 )
            break
        case 4:
            cola1.position = CGPoint(x: 0, y:-400 )
        case 5:
            cola1.position = CGPoint(x: 0, y:-430 )
            break
        case 6:
            cola1.position = CGPoint(x: 0, y:-460 )
            break
        case 7:
            cola1.position = CGPoint(x: 0, y: -490 )
            break
        case 8:
            cola1.position = CGPoint(x: 0, y:-510 )
            break
        case 9:
            cola1.position = CGPoint(x: 0, y:-540 )
            break
        case 10:
            cola1.position = CGPoint(x: 0, y:-570 )
            break
        case 11:
            cola1.position = CGPoint(x: 0, y:-600 )
            break
        case 12:
            cola1.position = CGPoint(x: 0, y:-630 )
            break
        case 13:
            cola1.position = CGPoint(x: 0, y:-660 )
            break
        case 14:
            cola1.position = CGPoint(x: 0, y: -690)
            break
        default:
            break
        }
        cola1.zPosition = 1
        cola1.setScale(0.5)
        cola1.physicsBody?.affectedByGravity = false
        cola1.physicsBody?.isDynamic = false
        self.cola.append(cola1)
        numero[index] = true
        index = index + 1
        numeroColas = numeroColas + 1
    }
    func crearMensajeGanador()
    {
        gana = SKSpriteNode(imageNamed: "ganaste")
        gana.setScale(0.5)
        gana.position = CGPoint(x: 0, y: 0)
        gana.zPosition = 4
        addChild(gana)
    crearRegreso()

    }
    func crearRegreso()
    {
        regreso = SKSpriteNode(imageNamed: "boton_back")
        regreso.name = "gana"
        regreso.position = CGPoint(x: 0, y: -500)
        regreso.setScale(0.5)
        regreso.zPosition = 5
        self.addChild(regreso)
    }
    func crearMensajePerdedor()
    {
        
        pierde = SKSpriteNode(imageNamed: "perdiste")
        pierde.setScale(0.5)
        pierde.position = CGPoint(x: 0, y: 0)
        pierde.zPosition = 4
        addChild(pierde)
       crearRegreso()
    }
    
    override func sceneDidLoad() {
        let sonidoURL = Bundle.main.url(forResource: "sonido_respuestaincorrecta", withExtension: "mp3")
        AudioServicesCreateSystemSoundID(sonidoURL! as CFURL, &respuestaEquivocada)
        let sonidoURLRespuestaBuena = Bundle.main.url(forResource: "sonido_respuestacorrecta", withExtension: "mp3")
        AudioServicesCreateSystemSoundID(sonidoURLRespuestaBuena! as CFURL, &respuestaBuena)
        let sonidoURLRGanas = Bundle.main.url(forResource: "sonido_ganaste", withExtension: "mp3")
        AudioServicesCreateSystemSoundID(sonidoURLRGanas! as CFURL, &ganas)
        let sonidoURLPierdes = Bundle.main.url(forResource: "sonido_gameover", withExtension: "mp3")
        AudioServicesCreateSystemSoundID(sonidoURLPierdes! as CFURL, &gameOver)
        let fondo = Bundle.main.url(forResource: "sonido_musicadefondo", withExtension: "mp3")
        do {
            try reproductor = AVAudioPlayer(contentsOf: fondo!)
        }
        catch
        {
            print("No fondo")
        }
        reproductor.play()
        reproductor.numberOfLoops = -1
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.7)
        background = self.childNode(withName: "background") as! SKSpriteNode
        background.position = CGPoint(x: 0 , y: 0)
        background.zPosition = -1
        crearCabeza()
        crearOperacion()
        for index in 1...15
        {
            crearCola()
        }
        
        let pregunta = SKAction.run({
            ()
            in
            self.operacionLabel.removeFromParent()
            self.crearOperacion()
        })
        let del = SKAction.wait(forDuration: 10)
        let spawn = SKAction.sequence([pregunta, del])
        let spawnForever = SKAction.repeatForever(spawn)
        self.run(spawnForever, withKey: "pregunta")
        
        let respuestaAction = SKAction.run({
            ()
            in
            self.posicionRespuestaCorrecta = Int(arc4random_uniform(4))
            self.crearResultNode()
            self.crearResult2Node()
            self.crearResult3Node()
            self.crearResultCorrectaNode()
                    })
        let delay = SKAction.wait(forDuration: 10)
        let spawnDelay = SKAction.sequence([respuestaAction, delay])
        let spawnDelayForever = SKAction.repeatForever(spawnDelay)
        self.run(spawnDelayForever, withKey: "respuesta")
//
//        let respuestaCorrectaAction = SKAction.run({
//            ()
//            in self.crearResultCorrectaNode()
//        })
//        let delatC = SKAction.wait(forDuration: 7)
//        let spawnDelayC = SKAction.sequence([respuestaCorrectaAction, delatC])
//        let spawnDelayForeverC = SKAction.repeatForever(spawnDelayC)
//        self.run(spawnDelayForeverC, withKey: "respuestaCorrecta")
//
        
    }
    func crearResultNode()
    {
       
        print(posicionRespuestaCorrecta)
        animacionTime = animacionTime - 0.25
        resupuesta = SKSpriteNode(imageNamed: "punto")
        if posicionRespuestaCorrecta != 0 && resupuesta3.position != CGPoint(x:-300, y: 800) && resupuesta2.position != CGPoint(x:-300, y: 800)
        {
            resupuesta.position = CGPoint(x:-300, y: 800)
        }
         if posicionRespuestaCorrecta != 1 && resupuesta3.position != CGPoint(x:-100, y: 800) && resupuesta2.position != CGPoint(x:-100, y: 800)
        {
            resupuesta.position = CGPoint(x: -100, y: 800)
        }
         if posicionRespuestaCorrecta != 2  && resupuesta3.position != CGPoint(x:100, y: 800) && resupuesta2.position != CGPoint(x:100, y: 800)
        {
            resupuesta.position = CGPoint(x:100, y: 800)
        }
        if posicionRespuestaCorrecta != 3  && resupuesta3.position != CGPoint(x:300, y: 800) && resupuesta2.position != CGPoint(x:300, y: 800)
        {
            resupuesta.position = CGPoint(x:300, y: 800)
            
        }
        resupuesta.setScale(0.5)
        resupuesta.physicsBody = SKPhysicsBody(rectangleOf: resupuesta.size)
        resupuesta.physicsBody?.categoryBitMask = CuerpoFisico.respuesta
        resupuesta.physicsBody?.collisionBitMask = CuerpoFisico.cabeza
        resupuesta.physicsBody?.contactTestBitMask = CuerpoFisico.cabeza
        resupuesta.physicsBody?.isDynamic = false
       
        resupuesta.physicsBody?.affectedByGravity = false
        self.addChild(resupuesta)
        var sum = Int(arc4random_uniform(40)) - 20
        if sum == 0
        {
            sum = -1
        }
        res = "\(numero1 + numero2 + sum)"
        print(res)
        textMalaRes = SKLabelNode(text: res)
        textMalaRes.fontSize =  45
        textMalaRes.position = CGPoint(x: resupuesta.position.x, y: resupuesta.position.y - 15)
        textMalaRes.fontName = "Arial-BoldMT"
        textMalaRes.zPosition = 4
        
        self.addChild(textMalaRes)
        
        
        var arrayDeAcciones = [SKAction]()
        
        arrayDeAcciones.append(SKAction.move(to: CGPoint(x:resupuesta.position.x, y: -(self.frame.size.height + 30)), duration: TimeInterval(animacionTime)))
        
        arrayDeAcciones.append(SKAction.removeFromParent())
        
        resupuesta.run(SKAction.sequence(arrayDeAcciones))
        textMalaRes.run(SKAction.sequence(arrayDeAcciones))
    }
    
    func crearResult2Node()
    {
    
        resupuesta2 = SKSpriteNode(imageNamed: "punto")
        if posicionRespuestaCorrecta != 0 && resupuesta.position != CGPoint(x:-300, y: 800) && resupuesta3.position != CGPoint(x:-300, y: 800)
        {
            resupuesta2.position = CGPoint(x:-300, y: 800)
        }
         if posicionRespuestaCorrecta != 1 && resupuesta.position != CGPoint(x:-100, y: 800) && resupuesta3.position != CGPoint(x:-100, y: 800)
        {
            resupuesta2.position = CGPoint(x: -100, y: 800)
        }
         if posicionRespuestaCorrecta != 2 && resupuesta.position != CGPoint(x:100, y: 800)  && resupuesta3.position != CGPoint(x:100, y: 800)
        {
            resupuesta2.position = CGPoint(x:100, y: 800)
        }
         if posicionRespuestaCorrecta != 3 && resupuesta.position != CGPoint(x:300, y: 800)   && resupuesta3.position != CGPoint(x:300, y: 800)
        {
            resupuesta2.position = CGPoint(x:300, y: 800)
        }
        resupuesta2.setScale(0.5)
        resupuesta2.physicsBody = SKPhysicsBody(rectangleOf: resupuesta2.size)
        resupuesta2.physicsBody?.categoryBitMask = CuerpoFisico.respuesta
        resupuesta2.physicsBody?.collisionBitMask = CuerpoFisico.cabeza
        resupuesta2.physicsBody?.contactTestBitMask = CuerpoFisico.cabeza
        resupuesta2.physicsBody?.isDynamic = false
        
        resupuesta2.physicsBody?.affectedByGravity = false
        self.addChild(resupuesta2)
        var sum = Int(arc4random_uniform(40)) - 20
        if sum == 0
        {
            sum = -1
        }
        res = "\(numero1 + numero2 + sum)"
        textMalaRes2 = SKLabelNode(text: res)
        textMalaRes2.fontSize =  45
        textMalaRes2.position = CGPoint(x: resupuesta2.position.x, y: resupuesta2.position.y - 15)
        textMalaRes2.fontName = "Arial-BoldMT"
        textMalaRes2.zPosition = 4
        
        self.addChild(textMalaRes2)
        
        
        var arrayDeAcciones = [SKAction]()
        
        arrayDeAcciones.append(SKAction.move(to: CGPoint(x:resupuesta2.position.x, y: -(self.frame.size.height + 30)), duration: TimeInterval(animacionTime)))
        
        arrayDeAcciones.append(SKAction.removeFromParent())
        
        resupuesta2.run(SKAction.sequence(arrayDeAcciones))
        textMalaRes2.run(SKAction.sequence(arrayDeAcciones))
    }
    
    func crearResult3Node()
    {
        
        resupuesta3 = SKSpriteNode(imageNamed: "punto")
        if posicionRespuestaCorrecta != 0 && resupuesta.position != CGPoint(x:-300, y: 800) && resupuesta2.position != CGPoint(x:-300, y: 800)
        {
            resupuesta3.position = CGPoint(x:-300, y: 800)
        }
         if posicionRespuestaCorrecta != 1 && resupuesta.position != CGPoint(x:-100, y: 800) && resupuesta2.position != CGPoint(x:-100, y: 800)
        {
            resupuesta3.position = CGPoint(x: -100, y: 800)
        }
         if posicionRespuestaCorrecta != 2 && resupuesta.position != CGPoint(x:100, y: 800) && resupuesta2.position != CGPoint(x:100, y: 800)
        {
            resupuesta3.position = CGPoint(x:100, y: 800)
        }
         if posicionRespuestaCorrecta != 3 && resupuesta.position != CGPoint(x:300, y: 800) && resupuesta2.position != CGPoint(x:300, y: 800)
        {
            resupuesta3.position = CGPoint(x:300, y: 800)
        }
        resupuesta3.setScale(0.5)
        resupuesta3.physicsBody = SKPhysicsBody(rectangleOf: resupuesta3.size)
        resupuesta3.physicsBody?.categoryBitMask = CuerpoFisico.respuesta
        resupuesta3.physicsBody?.collisionBitMask = CuerpoFisico.cabeza
        resupuesta3.physicsBody?.contactTestBitMask = CuerpoFisico.cabeza
        resupuesta3.physicsBody?.isDynamic = false
        
        resupuesta3.physicsBody?.affectedByGravity = false
        self.addChild(resupuesta3)
        var sum = Int(arc4random_uniform(40)) - 20
        if sum == 0
        {
            sum = -1
        }
        res = "\(numero1 + numero2 + sum)"
        textMalaRes3 = SKLabelNode(text: res)
        textMalaRes3.fontSize =  45
        textMalaRes3.position = CGPoint(x: resupuesta3.position.x, y: resupuesta3.position.y - 15)
        textMalaRes3.fontName = "Arial-BoldMT"
        textMalaRes3.zPosition = 4
        
        self.addChild(textMalaRes3)
        
        
        var arrayDeAcciones = [SKAction]()
        
        arrayDeAcciones.append(SKAction.move(to: CGPoint(x:resupuesta3.position.x, y: -(self.frame.size.height + 30)), duration: TimeInterval(animacionTime)))
        
        arrayDeAcciones.append(SKAction.removeFromParent())
        
        resupuesta3.run(SKAction.sequence(arrayDeAcciones))
        textMalaRes3.run(SKAction.sequence(arrayDeAcciones))
    }
    
    func crearResultCorrectaNode()
    {
        var respuestaB = true
        print(posicionRespuestaCorrecta)
        posicionRespuestaCorrecta = Int(arc4random_uniform(3))
        respuestaCorrecta = SKSpriteNode(imageNamed: "punto")
        respuestaCorrecta.setScale(0.5)
        respuestaCorrecta.physicsBody = SKPhysicsBody(rectangleOf: respuestaCorrecta.size)
        respuestaCorrecta.physicsBody?.categoryBitMask = CuerpoFisico.respuestaCorrecta
        respuestaCorrecta.physicsBody?.collisionBitMask = CuerpoFisico.cabeza
        respuestaCorrecta.physicsBody?.contactTestBitMask = CuerpoFisico.cabeza
        respuestaCorrecta.physicsBody?.isDynamic = true
       
        respuestaCorrecta.physicsBody?.affectedByGravity = false
        self.addChild(respuestaCorrecta)
        switch posicionRespuestaCorrecta {
        case 0 where resupuesta.position != CGPoint(x:-300, y: 800) && resupuesta2.position != CGPoint(x:-300, y: 800) && resupuesta3.position != CGPoint(x:-300, y: 800):
            respuestaCorrecta.position = CGPoint(x:-300, y: 800)
            
        case 1 where resupuesta.position != CGPoint(x:-100, y: 800) && resupuesta2.position != CGPoint(x:-100, y: 800) && resupuesta3.position != CGPoint(x:-100, y: 800):
            respuestaCorrecta.position = CGPoint(x: -100, y: 800)
            
        case 2 where resupuesta.position != CGPoint(x:100, y: 800) && resupuesta2.position != CGPoint(x:100, y: 800) && resupuesta3.position != CGPoint(x:100, y: 800):
            respuestaCorrecta.position = CGPoint(x:100, y: 800)
            
        case 3 where resupuesta.position != CGPoint(x:300, y: 800) && resupuesta2.position != CGPoint(x:300, y: 800) && resupuesta3.position != CGPoint(x:300, y: 800):
            respuestaCorrecta.position = CGPoint(x:300, y: 800)
        default:
            if resupuesta.position.x < 150 && resupuesta2.position.x < 150 && resupuesta3.position.x < 150
            {
            respuestaCorrecta.position = CGPoint(x:300, y:800)
            }
            else if resupuesta.position.x > -150 && resupuesta2.position.x > -150 && resupuesta3.position.x > -150
            {
               respuestaCorrecta.position = CGPoint(x:-300, y:800)
            }
            else if  resupuesta.position.x == -100 || resupuesta2.position.x == -100 || resupuesta3.position.x == -100
            {
           
                 respuestaCorrecta.position = CGPoint(x:100, y:800)
            }
            else
            {
                respuestaCorrecta.position = CGPoint(x:-100, y:800)
            }
          
            break
        }
        

        res = "\(numero1 + numero2)"
        print(res)
        if respuestaB == true
        {
        textRespuesta = SKLabelNode(text: res)
        }
        textRespuesta.fontSize =  45
        textRespuesta.position = CGPoint(x: respuestaCorrecta.position.x, y: respuestaCorrecta.position.y - 15)
        textRespuesta.zPosition = 4
        textRespuesta.fontName = "Arial-BoldMT"
        
        self.addChild(textRespuesta)
        
        var arrayDeAcciones = [SKAction]()
        
        arrayDeAcciones.append(SKAction.move(to: CGPoint(x:respuestaCorrecta.position.x, y: -(self.frame.size.height + 30)), duration: TimeInterval(animacionTime)))
        
        arrayDeAcciones.append(SKAction.removeFromParent())
        textRespuesta.run(SKAction.sequence(arrayDeAcciones))
        respuestaCorrecta.run(SKAction.sequence(arrayDeAcciones))
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
           
        if atPoint(location).name == "Regreso"{
            addChild(background)
            numeroVidas = 1
            numeroColas = 0
            let scene = MainMenuScene(fileNamed: "MainMenu");
            scene?.scaleMode = SKSceneScaleMode.aspectFill;
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
        }
            if atPoint(location).name == "gana"{
                addChild(background)
                numeroVidas = 1
                numeroColas = 0
                let scene = MainMenuScene(fileNamed: "MainMenu");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
            }
        
    }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
              let location = touch.location(in: self)
            if !(self.scene?.isPaused)!
            {
                if (atPoint(location).name == "Pause"){
                    if reproductor.isPlaying
                    {
                        reproductor.pause()
                    }
                    self.scene?.isPaused = true
                    resumeB = SKSpriteNode(imageNamed:"boton_play")
                    quitB = SKSpriteNode(imageNamed:"boton_exit")
                    resumeB.name = "Resume"
                    resumeB.zPosition = 5
                    resumeB.setScale(0.5)
                    resumeB.anchorPoint = CGPoint(x:0.5, y:0.5 )
                    resumeB.position = CGPoint(x:0, y: 0)
                    quitB.name = "Quit"
                    quitB.setScale(0.5)
                    quitB.zPosition = 5
                    quitB.anchorPoint = CGPoint(x:0.5, y:0.5 )
                    quitB.position = CGPoint(x: 300 , y: -600)
                    self.addChild(resumeB)
                    self.addChild(quitB)
                }
            }
            if (self.scene?.isPaused)!
            {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                if atPoint(location).name == "Resume"{
                    quitB.removeFromParent()
                    resumeB.removeFromParent()
                    reproductor.play()
                    self.scene?.isPaused = false
                }
                if atPoint(location).name == "Quit"{
                    removeAllActions()
                    removeAllChildren()
                    addChild(background)
                    reproductor.stop()
                    numeroVidas = 1
                    numeroColas = 0
                    self.scene?.isPaused = false
                    let scene = MainMenuScene(fileNamed: "MainMenu");
                    scene?.scaleMode = SKSceneScaleMode.aspectFill;
                    self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
                }
                if atPoint(location).name == "Regreso"{
                    addChild(background)
                    numeroVidas = 1
                    numeroColas = 0
                    reproductor.stop()
                    let scene = MainMenuScene(fileNamed: "MainMenu");
                    scene?.scaleMode = SKSceneScaleMode.aspectFill;
                    self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
                }
                
            }
            
           
            
            cabeza.run(SKAction.moveTo(x: location.x, duration: 0.25))
            var d = 0.01
            for i in cola
            {
                i.run(SKAction.moveTo(x: cabeza.position.x, duration: d))
                d = d + 0.025
            }
            }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        
        if firstBody.categoryBitMask == CuerpoFisico.cabeza && secondBody.categoryBitMask == CuerpoFisico.respuesta ||
            firstBody.categoryBitMask == CuerpoFisico.respuesta && secondBody.categoryBitMask == CuerpoFisico.cabeza
        {
            AudioServicesPlaySystemSound(respuestaEquivocada)
            if numeroVidas  > 1
            {
                if firstBody.categoryBitMask == CuerpoFisico.respuesta
                {
                    
                    resupuesta.removeFromParent()
                    resupuesta2.removeFromParent()
                    resupuesta3.removeFromParent()
                    textMalaRes.removeFromParent()
                    textMalaRes2.removeFromParent()
                    textMalaRes3.removeFromParent()
                    respuestaCorrecta.removeFromParent()
                    textRespuesta.removeFromParent()
                    numeroVidas = numeroVidas - 1
                    cola[numeroVidas].removeFromParent()
                }
                else if secondBody.categoryBitMask == CuerpoFisico.respuesta
                {
                    respuestaCorrecta.removeFromParent()
                    textRespuesta.removeFromParent()
                    resupuesta2.removeFromParent()
                    resupuesta3.removeFromParent()
                    textMalaRes.removeFromParent()
                    textMalaRes2.removeFromParent()
                    textMalaRes3.removeFromParent()
                    resupuesta.removeFromParent()
                    textMalaRes.removeFromParent()
                    numeroVidas = numeroVidas - 1
                    cola[numeroVidas].removeFromParent()
                }
            }
            else
            {
                print("acabado")
                reproductor.stop()
                 AudioServicesPlaySystemSound(gameOver)
                removeAllActions()
                removeAllChildren()
                crearMensajePerdedor()
            }
        }
            
            
            
        else if firstBody.categoryBitMask == CuerpoFisico.cabeza && secondBody.categoryBitMask == CuerpoFisico.respuestaCorrecta ||
            firstBody.categoryBitMask == CuerpoFisico.respuestaCorrecta && secondBody.categoryBitMask == CuerpoFisico.cabeza
        {
            AudioServicesPlaySystemSound(respuestaBuena)
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            if numeroVidas < 10
            {
                if firstBody.categoryBitMask == CuerpoFisico.respuestaCorrecta
                {
                    resupuesta.removeFromParent()
                    textMalaRes.removeFromParent()
                    resupuesta2.removeFromParent()
                    resupuesta3.removeFromParent()
                    textMalaRes.removeFromParent()
                    textMalaRes2.removeFromParent()
                    textMalaRes3.removeFromParent()
                    respuestaCorrecta.removeFromParent()
                    textRespuesta.removeFromParent()
                    textMalaRes.removeFromParent()
                    self.addChild(cola[numeroVidas])
                    numeroVidas = numeroVidas + 1
                }
                else if secondBody.categoryBitMask == CuerpoFisico.respuestaCorrecta
                {
                    resupuesta.removeFromParent()
                    textMalaRes.removeFromParent()
                    resupuesta2.removeFromParent()
                    resupuesta3.removeFromParent()
                    textMalaRes.removeFromParent()
                    textMalaRes2.removeFromParent()
                    textMalaRes3.removeFromParent()
                    respuestaCorrecta.removeFromParent()
                    textRespuesta.removeFromParent()
                    textMalaRes.removeFromParent()
                    self.addChild(cola[numeroVidas])
                    numeroVidas = numeroVidas + 1
                }
            }
            else
            {
                
                print("acabado")
                removeAllActions()
                removeAllChildren()
                reproductor.stop()
                crearMensajeGanador()
                 AudioServicesPlaySystemSound(ganas)
            }
            
        }
        
    }
    func createPausePanel(){
        pausePanel = self.childNode(withName: "Pause") as! SKSpriteNode
    }
    
    
}
